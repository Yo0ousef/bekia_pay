part of 'user_profile_cubit.dart';

mixin _$UserProfileState {}

extension UserProfileStatePatterns on UserProfileState {
  T maybeWhen<T extends Object?>({
    T Function()? loading,
    T Function()? updating,
    T Function(UserEntity user)? success,
    T Function(String message)? failure,
    required T Function() orElse,
  }) {
    switch (this) {
      case _Loading():
        if (loading != null) return loading();
        break;
      case _Updating():
        if (updating != null) return updating();
        break;
      case _Success(:final user):
        if (success != null) return success(user);
        break;
      case _Failure(:final message):
        if (failure != null) return failure(message);
        break;
    }
    return orElse();
  }

  T? whenOrNull<T extends Object?>({
    T? Function()? loading,
    T? Function()? updating,
    T? Function(UserEntity user)? success,
    T? Function(String message)? failure,
  }) => switch (this) {
    _Loading() => loading?.call(),
    _Updating() => updating?.call(),
    _Success(:final user) => success?.call(user),
    _Failure(:final message) => failure?.call(message),
    _ => null,
  };
}

final class _Loading implements UserProfileState {
  const _Loading();
}

final class _Updating implements UserProfileState {
  const _Updating();
}

final class _Success implements UserProfileState {
  final UserEntity user;
  const _Success(this.user);
}

final class _Failure implements UserProfileState {
  final String message;
  const _Failure(this.message);
}
