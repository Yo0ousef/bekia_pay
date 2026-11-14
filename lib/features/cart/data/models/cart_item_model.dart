import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';

class CartItemModel {
  final String productId;
  final String name;
  final int quantity;
  final String imageUrl;
  final num pricePoints;

  const CartItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.imageUrl,
    required this.pricePoints,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final productId = json['productId'];
    final name = json['name'];
    final quantity = json['quantity'] ?? json['count'];
    final imageUrl = json['imageUrl'];
    final pricePoints = json['pricePoints'];

    if (productId is! String || productId.trim().isEmpty) {
      throw const FormatException('Cart item productId must be a non-empty string');
    }
    if (name is! String) {
      throw const FormatException('Cart item name must be a string');
    }
    if (quantity is! num || quantity <= 0 || quantity % 1 != 0) {
      throw const FormatException('Cart item quantity must be a positive integer');
    }
    if (imageUrl is! String) {
      throw const FormatException('Cart item imageUrl must be a string');
    }
    if (pricePoints is! num || !pricePoints.isFinite || pricePoints < 0) {
      throw const FormatException('Cart item pricePoints must be a non-negative number');
    }

    return CartItemModel(
      productId: productId,
      name: name,
      quantity: quantity.toInt(),
      imageUrl: imageUrl,
      pricePoints: pricePoints,
    );
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) => CartItemModel(
    productId: entity.productId,
    name: entity.name,
    quantity: entity.quantity,
    imageUrl: entity.imageUrl,
    pricePoints: entity.pricePoints,
  );

  CartItemEntity toEntity() => CartItemEntity(
    productId: productId,
    name: name,
    quantity: quantity,
    imageUrl: imageUrl,
    pricePoints: pricePoints,
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'quantity': quantity,
    'imageUrl': imageUrl,
    'pricePoints': pricePoints,
  };
}
