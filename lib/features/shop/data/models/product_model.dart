import 'package:bekia_pay/features/shop/domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String productName;
  final String description;
  final num pricePoints;
  final num discountPercentage;
  final num finalPricePoints;
  final String imageUrl;
  final String categoryId;
  final bool inStock;
  final num quantityAvailable;
  final num orderPriority;

  const ProductModel({
    required this.id,
    required this.productName,
    required this.description,
    required this.pricePoints,
    required this.discountPercentage,
    required this.finalPricePoints,
    required this.imageUrl,
    required this.categoryId,
    required this.inStock,
    required this.quantityAvailable,
    required this.orderPriority,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      productName: json['product_name'] ?? '',
      description: json['description'] ?? '',
      pricePoints: json['price_points'] ?? 0,
      discountPercentage: json['discount_percentage'] ?? 0,
      finalPricePoints: json['final_price_points'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      categoryId: json['category_id'].toString(),
      inStock: json['in_stock'] ?? false,
      quantityAvailable: json['quantity_available'] ?? 0,
      orderPriority: json['order_priority'] ?? 0,
    );
  }

  ProductEntity toEntity() => ProductEntity(
    id: id,
    productName: productName,
    description: description,
    pricePoints: pricePoints,
    discountPercentage: discountPercentage,
    finalPricePoints: finalPricePoints,
    imageUrl: imageUrl,
    categoryId: categoryId,
    inStock: inStock,
    quantityAvailable: quantityAvailable,
    orderPriority: orderPriority,
  );
}
