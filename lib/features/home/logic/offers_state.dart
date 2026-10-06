part of 'offers_cubit.dart';

@freezed
class OffersState<T> with _$OffersState {
  const factory OffersState.loading() = _Loading;

  const factory OffersState.success(T data) = _Success<T>;

  const factory OffersState.failure(String message) = _Failure;
}
