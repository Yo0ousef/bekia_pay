class OrderItemModel {
  final String id;
  final int quantity;
  final num points;
  final String productName;
  final String productImage;

  OrderItemModel({
    required this.id,
    required this.quantity,
    required this.points,
    required this.productName,
    required this.productImage,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['products'] ?? {};
    return OrderItemModel(
      id: json['id'].toString(),
      quantity: json['quantity'] ?? 0,
      points: json['points'] ?? 0,
      productName: product['product_name'] ?? 'Unknown Product',
      productImage: product['image_url'] ?? '',
    );
  }
}
