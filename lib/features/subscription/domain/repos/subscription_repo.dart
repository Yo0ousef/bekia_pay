import 'package:bekia_pay/features/subscription/domain/entities/subscription_plan_entity.dart';

abstract class SubscriptionRepo {
  Future<List<SubscriptionPlanEntity>> getPlans();

  Future<String?> getActiveSubscriptionPlanId();
}
