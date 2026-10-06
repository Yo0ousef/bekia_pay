part of 'points_cubit.dart';

@freezed
class PointsState<T> with _$PointsState {
  const factory PointsState.loading() = _Loading;

  const factory PointsState.success(T points) = _Success<T>;

  const factory PointsState.failure(String message) = _Failure;
}
