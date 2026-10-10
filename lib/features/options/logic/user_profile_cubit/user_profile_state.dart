part of 'user_profile_cubit.dart';

@freezed
class UserProfileState<T> with _$UserProfileState {
  const factory UserProfileState.loading() = _Loading;

  const factory UserProfileState.success(T data) = _Success;

  const factory UserProfileState.failure(String message) = _Failure;
}
