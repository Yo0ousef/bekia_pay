abstract class FavouriteRepo {
  Future<List<String>> getFavouriteProductsIds();

  Future<void> addFavourite(String productId);

  Future<void> removeFavourite(String productId);
}
