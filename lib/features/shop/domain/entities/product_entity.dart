class ProductEntity {
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

  const ProductEntity({
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

  ProductEntity copyWith({num? quantityAvailable, bool? inStock}) =>
      ProductEntity(
        id: id,
        productName: productName,
        description: description,
        pricePoints: pricePoints,
        discountPercentage: discountPercentage,
        finalPricePoints: finalPricePoints,
        imageUrl: imageUrl,
        categoryId: categoryId,
        inStock: inStock ?? this.inStock,
        quantityAvailable: quantityAvailable ?? this.quantityAvailable,
        orderPriority: orderPriority,
      );
}
