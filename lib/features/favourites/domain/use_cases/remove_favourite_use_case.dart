import 'package:bekia_pay/features/favourites/domain/repos/favourite_repo.dart';

class RemoveFavouriteUseCase {
  final FavouriteRepo _favouriteRepo;

  RemoveFavouriteUseCase(this._favouriteRepo);

  Future<void> call(String productId) {
    return _favouriteRepo.removeFavourite(productId);
  }
}
