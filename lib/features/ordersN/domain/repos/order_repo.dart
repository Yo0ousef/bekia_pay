import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';

abstract class OrderRepo {
  Future<List<OrderEntity>> getOrders();

  Future<void> cancelOrder(String orderId);
}
