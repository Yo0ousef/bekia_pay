part of 'order_cubit.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.loading() = _Loading;

  const factory OrderState.success(List<OrderEntity> orders) = _Success;

  const factory OrderState.failure(String message) = _Failure;
}
