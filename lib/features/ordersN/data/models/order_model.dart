import 'package:bekia_pay/features/ordersN/data/models/order_item_model.dart';
import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.items,
    required super.userId,
    required super.createdAt,
    required super.status,
    required super.totalPoints,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json["order_items"] as List<dynamic>? ?? [];
    final itemsList = rawItems
        .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
        .toList();

    DateTime parsedDate = DateTime.now();
    if (json["created_at"] != null) {
      parsedDate = DateTime.tryParse(json["created_at"].toString()) ?? DateTime.now();
    }

    return OrderModel(
      id: json["id"]?.toString() ?? '',
      status: json["status"]?.toString() ?? 'pending',
      items: itemsList,
      userId: json["user_id"]?.toString() ?? '',
      createdAt: parsedDate,
      totalPoints: (json["total_points"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
