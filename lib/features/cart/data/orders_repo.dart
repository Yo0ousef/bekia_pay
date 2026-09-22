import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/cart/data/models/order_model.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ApiResult<void>> placeOrder({
    required List<CartItemModel> items,
  }) async {
    try {
      await _supabase.rpc(
        'create_order',
        params: {
          'p_items': items
              .map(
                (e) => {
                  'product_id': e.productId,
                  'quantity': e.count,
                  'points': e.pricePoints,
                },
              )
              .toList(),
        },
      );
      return ApiResult.success(null);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<ApiResult<List<OrderModel>>> getOrders() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('Not logged in');

      final response = await _supabase
          .from('orders')
          .select('*, order_items(*, products(*))')
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      final List<OrderModel> orders = (response as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
      return ApiResult.success(orders);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<ApiResult<void>> cancelOrder(String orderId) async {
    try {
      await _supabase.rpc(
        'cancel_order_and_delete',
        params: {'p_order_id': orderId},
      );
      return ApiResult.success(null);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<ApiResult<int>> getMyPoints() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('Not logged in');

      final data = await _supabase
          .from('profiles')
          .select('points_balance')
          .eq('id', userId)
          .single();
      final int points = (data['points_balance'] as num).toInt();
      return ApiResult.success(points);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
