import 'package:bekia_pay/features/ordersN/domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.pointsEach,
    required super.imageUrl,
    required super.lineTotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final productJson = json['products'] as Map<String, dynamic>? ?? {};
    final int qty = json['quantity'] as int? ?? 1;
    final double totalPts =
        (json['line_total_points'] as num?)?.toDouble() ?? 0.0;
    final double ptsEach = qty > 0 ? (totalPts / qty) : totalPts;

    return OrderItemModel(
      id: json['id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      productName: productJson['product_name']?.toString() ?? 'Product',
      quantity: qty,
      imageUrl: productJson['image_url']?.toString() ?? '',
      pointsEach: ptsEach,
      lineTotal: totalPts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'image_url': imageUrl,
      'points_each': pointsEach,
      'line_total': lineTotal,
    };
  }
}
