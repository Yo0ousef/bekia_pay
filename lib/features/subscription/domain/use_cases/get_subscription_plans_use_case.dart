import 'package:bekia_pay/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:bekia_pay/features/subscription/domain/repos/subscription_repo.dart';

class GetSubscriptionPlansUseCase {
  final SubscriptionRepo repository;

  const GetSubscriptionPlansUseCase({required this.repository});

  Future<List<SubscriptionPlanEntity>> call() => repository.getPlans();
}
