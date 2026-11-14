import 'package:bekia_pay/features/subscription/domain/repos/subscription_repo.dart';

class GetActiveSubscriptionPlanIdUseCase {
  final SubscriptionRepo repository;

  const GetActiveSubscriptionPlanIdUseCase({required this.repository});

  Future<String?> call() => repository.getActiveSubscriptionPlanId();
}
