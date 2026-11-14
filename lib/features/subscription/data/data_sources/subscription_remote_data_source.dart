import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/features/subscription/data/models/subscription_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionModel>> getPlans();

  Future<String?> getActiveSubscriptionPlanId();
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
  Future<String?> getActiveSubscriptionPlanId() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return null;

    final subscriptions = await databaseClient.getData(
      table: 'current_user_subscription',
      selectQuery: 'plan_id',
      queryParams: {'user_id': user.id, 'current_state': 'active'},
    );
    if (subscriptions.isEmpty) return null;
    return subscriptions.first['plan_id']?.toString();
  }
}
