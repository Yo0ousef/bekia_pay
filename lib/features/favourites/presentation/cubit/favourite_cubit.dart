import 'package:bekia_pay/features/favourites/domain/use_cases/add_favourite_use_case.dart';
import 'package:bekia_pay/features/favourites/domain/use_cases/get_favourite_ids_use_case.dart';
import 'package:bekia_pay/features/favourites/domain/use_cases/remove_favourite_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_cubit.freezed.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final Set<String> _pendingProductIds = {};
  int _fetchRequest = 0;
  final GetFavouriteIdsUseCase getFavouriteIdsUseCase;
  final AddFavouriteUseCase addFavouriteUseCase;
  final RemoveFavouriteUseCase removeFavouriteUseCase;

  FavouriteCubit({
    required this.getFavouriteIdsUseCase,
    required this.addFavouriteUseCase,
    required this.removeFavouriteUseCase,
  }) : super(const FavouriteState.initial());

  Future<void> getFavourites() async {
    final request = ++_fetchRequest;
    emit(const FavouriteState.loading());
    try {
      final ids = await getFavouriteIdsUseCase();
      if (isClosed || request != _fetchRequest) return;
      emit(FavouriteState.success(ids));
    } catch (error) {
      if (isClosed || request != _fetchRequest) return;
      emit(FavouriteState.failure(error.toString()));
    }
  }

  Future<bool> toggleFavorite(String productId) async {
    final favoriteIds = state.maybeWhen(
      success: (ids) => ids,
      orElse: () => null,
    );
    if (favoriteIds == null || !_pendingProductIds.add(productId)) return false;

    final wasFavorite = favoriteIds.contains(productId);
    final optimisticIds = List<String>.from(favoriteIds);
    if (wasFavorite) {
      optimisticIds.remove(productId);
    } else {
      optimisticIds.add(productId);
    }
    emit(FavouriteState.success(optimisticIds));

    try {
      if (wasFavorite) {
        await removeFavouriteUseCase(productId);
      } else {
        await addFavouriteUseCase(productId);
      }
      return true;
    } catch (_) {
      if (!isClosed) {
        // Preserve other optimistic changes that may have completed meanwhile.
        final latestIds = state.maybeWhen(
          success: (ids) => ids,
          orElse: () => optimisticIds,
        );
        final restoredIds = List<String>.from(latestIds);
        if (wasFavorite && !restoredIds.contains(productId)) {
          restoredIds.add(productId);
        } else if (!wasFavorite) {
          restoredIds.remove(productId);
        }
        emit(FavouriteState.success(restoredIds));
      }
      return false;
    } finally {
      _pendingProductIds.remove(productId);
    }
  }
}
