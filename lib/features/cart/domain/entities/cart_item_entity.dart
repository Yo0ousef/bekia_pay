class CartItemEntity {
  final String productId;
  final String name;
  final int quantity;
  final String imageUrl;
  final num pricePoints;

  const CartItemEntity({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.imageUrl,
    required this.pricePoints,
  });

  CartItemEntity copyWith({int? quantity}) => CartItemEntity(
    productId: productId,
    name: name,
    quantity: quantity ?? this.quantity,
    imageUrl: imageUrl,
    pricePoints: pricePoints,
  );
}
