part of 'check_out_cubit.dart';

mixin _$CheckOutState {}

extension CheckOutStatePatterns on CheckOutState {
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

final class _Initial implements CheckOutState {
  const _Initial();
}

final class _Loading implements CheckOutState {
  const _Loading();
}

final class _Success implements CheckOutState {
  const _Success();
}

final class _Failure implements CheckOutState {
  final String message;
  const _Failure(this.message);
}
