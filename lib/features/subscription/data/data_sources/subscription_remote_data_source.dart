import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/features/subscription/data/models/subscription_model.dart';
import 'package:bekia_pay/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionModel>> getPlans();

  Future<UserSubscriptionEntity?> getCurrentSubscription();

  Future<void> cancelPendingSubscription();
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final DatabaseClient databaseClient;
  final SupabaseClient supabaseClient;

  const SubscriptionRemoteDataSourceImpl({
    required this.databaseClient,
    required this.supabaseClient,
  });

  @override
  Future<List<SubscriptionModel>> getPlans() async {
    final plans = await databaseClient.getData(
      table: 'subscription_plans',
      queryParams: {'is_active': true},
      orderBy: 'price',
      ascending: true,
    );
    return plans.map(SubscriptionModel.fromJson).toList();
  }

  @override
  Future<UserSubscriptionEntity?> getCurrentSubscription() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return null;

    final rows = await databaseClient.getData(
      table: 'user_subscriptions',
      selectQuery: 'plan_id,status,expires_at,created_at',
      queryParams: {'user_id': user.id},
      orderBy: 'created_at',
      ascending: false,
    );

    final now = DateTime.now().toUtc();
    UserSubscriptionEntity? activeSubscription;
    UserSubscriptionEntity? pendingSubscription;
    for (final row in rows) {
      final status = row['status']?.toString();
      DateTime? expiresAt;
      final rawExpiresAt = row['expires_at'];
      if (rawExpiresAt != null) {
        expiresAt = DateTime.tryParse(rawExpiresAt.toString())?.toUtc();
      }

      final planId = row['plan_id']?.toString();
      if (planId == null || planId.isEmpty) continue;
      final subscription = UserSubscriptionEntity(
        planId: planId,
        status: status ?? '',
        expiresAt: expiresAt,
      );
      if (status == 'active' && expiresAt != null && expiresAt.isAfter(now)) {
        activeSubscription ??= subscription;
      } else if (status == 'pending') {
        pendingSubscription ??= subscription;
      }
    }
    return activeSubscription ?? pendingSubscription;
  }

  @override
  Future<void> cancelPendingSubscription() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw StateError('Not authenticated');

    await databaseClient.deleteDataWhere(
      table: 'user_subscriptions',
      queryParams: {'user_id': user.id, 'status': 'pending'},
    );
  }
}
