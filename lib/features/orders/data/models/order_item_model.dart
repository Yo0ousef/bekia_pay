import 'package:bekia_pay/core/utils/extensions/json_parser_extension.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_item_entity.dart';

class OrderItemModel {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double pointsEach;
  final String imageUrl;
  final double lineTotal;

  const OrderItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.pointsEach,
    required this.imageUrl,
    required this.lineTotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    const ctx = 'order_items';

    final id = json.parseRequiredString('id', contextName: ctx);
    final productId = json.parseRequiredString('product_id', contextName: ctx);

    // Quantity validation using the numeric parser helper
    final rawQuantity = json.parseNonNegativeDouble(
      'quantity',
      contextName: ctx,
    );
    if (rawQuantity < 1 || rawQuantity != rawQuantity.toInt()) {
      throw const FormatException(
        '$ctx.quantity must be a positive whole number',
      );
    }
    final quantity = rawQuantity.toInt();

    final lineTotalPoints = json.parseNonNegativeDouble(
      'line_total_points',
      contextName: ctx,
    );

    final rawProduct = json['products'];
    if (rawProduct is! Map) {
      throw const FormatException('$ctx.products must be an object');
    }

    late final Map<String, dynamic> productJson;
    try {
      productJson = Map<String, dynamic>.from(rawProduct);
    } on TypeError {
      throw const FormatException('Product keys must be strings');
    }

    // Using extensions on the nested products map with its own context
    const productCtx = 'products';
    final productName = productJson.parseRequiredString(
      'product_name',
      contextName: productCtx,
    );

    final rawImageUrl = productJson['image_url'];
    if (rawImageUrl != null && rawImageUrl is! String) {
      throw const FormatException('$productCtx.image_url must be a string');
    }

    final totalPoints = lineTotalPoints.toDouble();

    return OrderItemModel(
      id: id,
      productId: productId,
      productName: productName,
      quantity: quantity,
      imageUrl: rawImageUrl as String? ?? '',
      pointsEach: totalPoints / quantity,
      lineTotal: totalPoints,
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

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      productId: productId,
      productName: productName,
      quantity: quantity,
      pointsEach: pointsEach,
      imageUrl: imageUrl,
      lineTotal: lineTotal,
    );
  }
}
