import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/shop/data/favourite_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_cubit.freezed.dart';
part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepo _favouriteRepo;

  FavouriteCubit(this._favouriteRepo) : super(const FavouriteState.initial()) {
    getFavourites();
  }

  void getFavourites() async {
    emit(const FavouriteState.loading());
    final result = await _favouriteRepo.getFavouriteProductsIds();

    if (isClosed) return;

    result.when(
      success: (favoriteIds) {
        emit(FavouriteState.success(favoriteIds));
      },
      failure: (message) {
        emit(FavouriteState.failure(message));
      },
    );
  }

  void toggleFavorite(String productId) async {
    state.maybeWhen(
      success: (favoriteIds) async {
        final updatedIds = List<String>.from(favoriteIds);
        final isCurrentlyFav = updatedIds.contains(productId);

        if (isCurrentlyFav) {
          updatedIds.remove(productId);
        } else {
          updatedIds.add(productId);
        }
        emit(FavouriteState.success(updatedIds));
        isCurrentlyFav
            ? await _favouriteRepo.removeFavourite(productId)
            : await _favouriteRepo.addFavourite(productId);

        if (isClosed) return;
      },
      orElse: () {},
    );
  }
}
