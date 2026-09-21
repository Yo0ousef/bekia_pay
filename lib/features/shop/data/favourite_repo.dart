import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouriteRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ApiResult<List<String>>> getFavouriteProductsIds() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return ApiResult.failure('User not authenticated');
      }
      final List<dynamic> response = await _supabase
          .from('favorites')
          .select('product_id')
          .eq('user_id', user.id);

      final List<String> favoriteIds = response
          .map((item) => item['product_id'].toString())
          .toList();
      return ApiResult.success(favoriteIds);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<bool> addFavourite(String productId) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return false;
      }
      await _supabase.from('favorites').insert({
        'user_id': user.id,
        'product_id': productId,
      });
      return true;
    } catch (exception) {
      return false;
    }
  }

  Future<ApiResult<void>> removeFavourite(String productId) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return ApiResult.failure('User not authenticated');
      }
      await _supabase
          .from('favorites')
          .delete()
          .eq('user_id', user.id)
          .eq('product_id', productId);
      return ApiResult.success(null);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
