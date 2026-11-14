part of 'check_out_cubit.dart';

@freezed
class CheckOutState with _$CheckOutState {
  const factory CheckOutState.initial() = _Initial;

  const factory CheckOutState.loading() = _Loading;

  const factory CheckOutState.success() = _Success;

  const factory CheckOutState.failure(String message) = _Failure;
}
