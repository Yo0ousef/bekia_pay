import 'package:bekia_pay/core/shared/widgets/product_image.dart';
import 'package:flutter/material.dart';

Widget itemImage(BuildContext context, String imageUrl) {
  final theme = Theme.of(context);
  if (imageUrl.isEmpty) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.inventory_2_outlined,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
  return SizedBox(
    width: 64,
    height: 64,
    child: ProductImage(imageUrl: imageUrl),
  );
}
