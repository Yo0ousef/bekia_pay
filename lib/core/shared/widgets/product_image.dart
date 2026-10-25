import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: context.screenWidth * 0.2,
        height: context.screenHeight * 0.15,
        fit: BoxFit.cover,
        placeholder: (context, url) => AppConstants.loading.center,
        errorWidget: (_, _, _) =>
            Image.asset(ImageConstants.no_image, fit: BoxFit.cover),
      ),
    );
  }
}
