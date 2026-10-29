import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<String>> getFavouriteIds();

  Future<void> addFavourite(String productId);

  Future<void> removeFavourite(String productId);
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final SupabaseClient supabaseClient;
  final DatabaseClient databaseClient;

  FavouritesRemoteDataSourceImpl({
    required this.supabaseClient,
    required this.databaseClient,
  });

  @override
  Future<void> addFavourite(String productId) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('Not authenticated');
    }
    await databaseClient
        .insertData(
          table: 'favorites',
          data: {'user_id': userId, 'product_id': productId},
        )
        .timeout(10.sec);
  }

  @override
  Future<List<String>> getFavouriteIds() async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('Not authenticated');
    }
    final response = await databaseClient
        .getData(
          table: 'favorites',
          selectQuery: 'product_id',
          queryParams: {'user_id': userId},
        )
        .timeout(10.sec);
    return response.map((row) {
      final productId = row['product_id'];
      if (productId is! String || productId.trim().isEmpty) {
        throw const FormatException(
          'favorites.product_id must be a non-empty string',
        );
      }
      return productId;
    }).toList();
  }

  @override
  Future<void> removeFavourite(String productId) {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('Not authenticated');
    }
    return databaseClient
        .deleteDataWhere(
          table: 'favorites',
          queryParams: {'user_id': userId, 'product_id': productId},
        )
        .timeout(10.sec);
  }
}
