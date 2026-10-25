import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/features/ordersN/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();

  Future<void> cancelOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final DatabaseClient databaseClient;

  OrderRemoteDataSourceImpl({required this.databaseClient});

  @override
  Future<void> cancelOrder(String orderId) async {
    final supabase = Supabase.instance.client;
    await supabase.rpc(
      'cancel_order_and_delete',
      params: {'p_order_id': orderId},
    );
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await databaseClient.getData(
      table: "orders",
      selectQuery: '*, order_items(*, products(*))',
    );
    return response.map((json) => OrderModel.fromJson(json)).toList();
  }
}
