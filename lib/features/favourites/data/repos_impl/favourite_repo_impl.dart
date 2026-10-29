import 'package:bekia_pay/features/favourites/data/data_sources/favourites_remote_data_source.dart';
import 'package:bekia_pay/features/favourites/domain/repos/favourite_repo.dart';

class FavouriteRepoImpl implements FavouriteRepo {
  final FavouritesRemoteDataSource _favouritesRemoteDataSource;

  FavouriteRepoImpl(this._favouritesRemoteDataSource);

  @override
  Future<void> addFavourite(String productId) {
    return _favouritesRemoteDataSource.addFavourite(productId);
  }

  @override
  Future<List<String>> getFavouriteProductsIds() async {
    return _favouritesRemoteDataSource.getFavouriteIds();
  }

  @override
  Future<void> removeFavourite(String productId) {
    return _favouritesRemoteDataSource.removeFavourite(productId);
  }
}
