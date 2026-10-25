class OrderItemEntity {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double pointsEach;
  final double lineTotal;
  final String imageUrl;

  const OrderItemEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.pointsEach,
    required this.imageUrl,
    required this.lineTotal,
  });
}
