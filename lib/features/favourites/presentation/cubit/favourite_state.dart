part of 'favourite_cubit.dart';

@freezed
class FavouriteState with _$FavouriteState {
  const factory FavouriteState.initial() = _Initial;

  const factory FavouriteState.loading() = _Loading;

  const factory FavouriteState.success(List<String> favoriteIds) = _Success;

  const factory FavouriteState.failure(String message) = _Failure;
}
