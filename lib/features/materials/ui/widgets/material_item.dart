import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/features/materials/data/models/material_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MaterialItem extends StatelessWidget {
  final MaterialModel material;

  const MaterialItem({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .circular(12),
        border: .all(color: AppColors.blackColor.withAlpha(50)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withAlpha(100),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            material.materialName,
            style: ThemingTypography.styleRegular14(context)
                .copyWith(color: AppColors.secondaryDarkColor),
          ),
          8.vGap,
          ClipRRect(
            borderRadius: .circular(12),
            child: CachedNetworkImage(
              imageUrl: material.materialImage,
              fit: BoxFit.cover,
              placeholder: (_, _) => AppConstants.loading.center,
              errorWidget: (_, _, _) =>
                  Image.asset(ImageConstants.no_image, fit: .cover),
            ),
          ).expanded,
          8.vGap,
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  material.materialPoints,
                  style: ThemingTypography.styleRegular14(context)
                      .copyWith(color: AppColors.secondaryDarkColor),
                ),
                4.hGap,
                Icon(Icons.stars, color: AppColors.redColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
