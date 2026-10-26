import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/features/orders/data/models/order_model.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_item_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<void> placeOrder({required List<OrderItemRequest> items});

  Future<List<OrderModel>> getOrders();

  Future<void> cancelOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final DatabaseClient databaseClient;
  final SupabaseClient supabaseClient;

  OrderRemoteDataSourceImpl({
    required this.databaseClient,
    required this.supabaseClient,
  });

  @override
  Future<void> placeOrder({required List<OrderItemRequest> items}) async {
    await supabaseClient.rpc(
      'create_order',
      params: {
        'p_items': items
            .map(
              (item) => {
                'product_id': item.productId,
                'quantity': item.quantity,
              },
            )
            .toList(),
      },
    );
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await supabaseClient.rpc(
      'cancel_order_and_delete',
      params: {'p_order_id': orderId},
    );
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('Not authenticated');
    }

    final response = await databaseClient
        .getData(
          table: 'orders',
          selectQuery: '*, order_items(*, products(*))',
          queryParams: {'user_id': userId},
          orderBy: 'created_at',
          ascending: false,
        )
        .timeout(const Duration(seconds: 5));
    return response.map((json) => OrderModel.fromJson(json)).toList();
  }
}
