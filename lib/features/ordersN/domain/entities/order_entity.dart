import 'package:bekia_pay/features/ordersN/domain/entities/order_item_entity.dart';

class OrderEntity {
  final String id;
  final String userId;
  final double totalPoints;
  final String status;
  final List<OrderItemEntity> items;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.totalPoints,
    required this.items,
    required this.status,
    required this.createdAt,
  });
}
