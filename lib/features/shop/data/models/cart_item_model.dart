class CartItemModel {
  final String productId;
  final String name;
  final num count;
  final String imageUrl;
  final num pricePoints;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.count,
    required this.imageUrl,
    required this.pricePoints,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      count: json['count'] as num,
      imageUrl: json['imageUrl'] as String,
      pricePoints: json['pricePoints'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'count': count,
      'imageUrl': imageUrl,
      'pricePoints': pricePoints,
    };
  }
}
