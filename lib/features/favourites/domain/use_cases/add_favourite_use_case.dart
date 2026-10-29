import 'package:bekia_pay/features/favourites/domain/repos/favourite_repo.dart';

class AddFavouriteUseCase {
  final FavouriteRepo _favouriteRepo;

  AddFavouriteUseCase(this._favouriteRepo);

  Future<void> call(String productId) {
    return _favouriteRepo.addFavourite(productId);
  }
}
