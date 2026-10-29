import 'package:bekia_pay/features/favourites/domain/repos/favourite_repo.dart';

class GetFavouriteIdsUseCase {
  final FavouriteRepo _favouriteRepo;

  GetFavouriteIdsUseCase(this._favouriteRepo);

  Future<List<String>> call() {
    return _favouriteRepo.getFavouriteProductsIds();
  }
}
