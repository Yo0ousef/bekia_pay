import 'package:bekia_pay/features/cart/data/models/order_item_model.dart';

class OrderModel {
  final String id;
  final String status;
  final int totalPoints;
  final String createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalPoints,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'].toString(),
      status: json['status'] ?? 'Unknown',
      totalPoints: json['total_points'] ?? 0,
      createdAt: json['created_at'] ?? '',
      items:
          (json['order_items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
