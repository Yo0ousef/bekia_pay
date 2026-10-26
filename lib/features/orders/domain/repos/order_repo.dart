import 'package:bekia_pay/features/orders/domain/entities/order_item_request.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';

abstract class OrderRepo {
  Future<void> placeOrder({required List<OrderItemRequest> items});

  Future<List<OrderEntity>> getOrders();

  Future<void> cancelOrder(String orderId);
}
