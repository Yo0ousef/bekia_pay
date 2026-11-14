import 'package:bekia_pay/features/shop/domain/entities/product_entity.dart';
import 'package:bekia_pay/features/shop/presentation/views/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductItem(product: product);
      },
    );
  }
}
