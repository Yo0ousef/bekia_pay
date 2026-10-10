part of 'sign_out_cubit.dart';

@freezed
class SignOutState with _$SignOutState {
  const factory SignOutState.initial() = _Initial;

  const factory SignOutState.loading() = _Loading;

  const factory SignOutState.success() = _Success;

  const factory SignOutState.failure(String message) = _Failure;
}
