part of 'subscription_cubit.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.loading() = _Loading;

  const factory SubscriptionState.success(
    List<SubscriptionPlanEntity> plans,
    String? activePlanId,
  ) = _Success;

  const factory SubscriptionState.failure(String message) = _Failure;
}
