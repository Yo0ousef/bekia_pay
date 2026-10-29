part of 'user_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.loading() = _Loading;

  const factory UserProfileState.updating() = _Updating;

  const factory UserProfileState.success(UserEntity user) = _Success;

  const factory UserProfileState.failure(String message) = _Failure;
}
