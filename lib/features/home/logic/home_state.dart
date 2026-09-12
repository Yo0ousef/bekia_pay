part of 'home_cubit.dart';

@freezed
class HomeState<T> with _$HomeState {
  const factory HomeState.loading() = _Loading;

  const factory HomeState.success(T data) = _Success<T>;

  const factory HomeState.failure(String message) = _Failure;
}
