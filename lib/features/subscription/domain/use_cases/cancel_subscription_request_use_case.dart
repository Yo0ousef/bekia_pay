import 'package:bekia_pay/features/subscription/domain/repos/subscription_repo.dart';

class CancelSubscriptionRequestUseCase {
  final SubscriptionRepo repository;

  const CancelSubscriptionRequestUseCase(this.repository);

  Future<void> call() => repository.cancelPendingSubscription();
}
