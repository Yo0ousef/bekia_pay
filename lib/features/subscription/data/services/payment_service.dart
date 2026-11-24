import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/core/services/payment_service/payment_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CashOnDeliveryPaymentService implements PaymentService {
  final DatabaseClient databaseClient;
  final SupabaseClient supabaseClient;

  const CashOnDeliveryPaymentService({
    required this.databaseClient,
    required this.supabaseClient,
  });

  @override
  Future<PaymentResult> pay(PaymentRequest request) async {
    if (request.method != PaymentMethod.cashOnDelivery) {
      throw UnsupportedError('Unsupported payment method: ${request.method}');
    }

    final currentUser = supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw StateError('A signed-in user is required to subscribe.');
    }

    final now = DateTime.now().toUtc();
    final nextMonth = now.month == 12 ? 1 : now.month + 1;
    final nextMonthYear = now.month == 12 ? now.year + 1 : now.year;
    final lastDayOfNextMonth = DateTime.utc(
      nextMonthYear,
      nextMonth + 1,
      0,
    ).day;
    final expiresAt = DateTime.utc(
      nextMonthYear,
      nextMonth,
      now.day > lastDayOfNextMonth ? lastDayOfNextMonth : now.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
    final inserted = await databaseClient.insertData(
      table: 'user_subscriptions',
      data: {
        'user_id': currentUser.id,
        'plan_id': request.planId,
        'started_at': now.toIso8601String(),
        'expires_at': expiresAt.toIso8601String(),
        'status': 'pending',
        'payment_reference': 'cash_on_delivery',
      },
    );

    final id = inserted['id']?.toString();
    if (id == null || id.isEmpty) {
      throw const FormatException('Subscription insert did not return an id.');
    }
    return PaymentResult(
      subscriptionId: id,
      status: 'pending',
      paymentReference: 'cash_on_delivery',
    );
  }
}
