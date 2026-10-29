part of 'update_password_cubit.dart';

mixin _$UpdatePasswordState {}

extension UpdatePasswordStatePatterns on UpdatePasswordState {
  T maybeWhen<T extends Object?>({
    T Function()? initial,
    T Function()? loading,
    T Function()? success,
    T Function(String message)? failure,
    required T Function() orElse,
  }) {
    switch (this) {
      case _Initial():
        if (initial != null) return initial();
        break;
      case _Loading():
        if (loading != null) return loading();
        break;
      case _Success():
        if (success != null) return success();
        break;
      case _Failure(:final message):
        if (failure != null) return failure(message);
        break;
    }
    return orElse();
  }

  T? whenOrNull<T extends Object?>({
    T? Function()? initial,
    T? Function()? loading,
    T? Function()? success,
    T? Function(String message)? failure,
  }) => switch (this) {
    _Initial() => initial?.call(),
    _Loading() => loading?.call(),
    _Success() => success?.call(),
    _Failure(:final message) => failure?.call(message),
    _ => null,
  };
}

final class _Initial implements UpdatePasswordState {
  const _Initial();
}

final class _Loading implements UpdatePasswordState {
  const _Loading();
}

final class _Success implements UpdatePasswordState {
  const _Success();
}

final class _Failure implements UpdatePasswordState {
  final String message;
  const _Failure(this.message);
}
