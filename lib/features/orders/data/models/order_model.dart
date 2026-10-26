import 'package:bekia_pay/core/utils/extensions/json_parser_extension.dart';
import 'package:bekia_pay/features/orders/data/models/order_item_model.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';

class OrderModel {
  final String id;
  final List<OrderItemModel> items;
  final String userId;
  final DateTime createdAt;
  final String status;
  final double totalPoints;

  const OrderModel({
    required this.id,
    required this.items,
    required this.userId,
    required this.createdAt,
    required this.status,
    required this.totalPoints,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    const ctx = 'orders';
    final rawItems = json['order_items'];
    if (rawItems is! List) {
      throw const FormatException('$ctx.order_items must be a list');
    }
    return OrderModel(
      id: json.parseRequiredString('id', contextName: ctx),
      userId: json.parseRequiredString('user_id', contextName: ctx),
      status: json.parseRequiredString('status', contextName: ctx),
      createdAt: json.parseRequiredDateTime('created_at', contextName: ctx),
      totalPoints: json.parseNonNegativeDouble(
        'total_points',
        contextName: ctx,
      ),
      items: rawItems.map((item) {
        if (item is! Map) {
          throw const FormatException('Each order item must be an object');
        }
        return OrderItemModel.fromJson(Map<String, dynamic>.from(item));
      }).toList(),
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      items: items.map((item) => item.toEntity()).toList(),
      userId: userId,
      createdAt: createdAt,
      status: status,
      totalPoints: totalPoints,
    );
  }
}
