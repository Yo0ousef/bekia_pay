import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewItem extends StatelessWidget {
  final CartItemModel item;

  const CartViewItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        height: context.screenHeight * 0.20,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.disableDarkColor,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (item.imageUrl == 'dummy image')
              Container(
                width: context.screenWidth * 0.2,
                height: context.screenHeight * 0.15,
                decoration: const BoxDecoration(
                  color: AppColors.disableLightColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              )
            else
              CachedNetworkImage(
                imageUrl: item.imageUrl,
                width: context.screenWidth * 0.2,
                height: context.screenHeight * 0.15,
                fit: BoxFit.cover,
                placeholder: (_, _) => Center(
                  child: CircularProgressIndicator(color: theme.primaryColor),
                ),
                errorWidget: (_, _, _) =>
                    Image.asset(ImageConstants.no_image, fit: .cover),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: ThemingTypography.styleMedium14(context)
                      .copyWith(color: AppColors.secondaryDarkColor),
                ),
                Text(
                  "Amount: ${item.count}",
                  style: ThemingTypography.styleRegular12(context),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                  ),
                  onPressed: () {
                    context.read<CartCubit>().removeItem(item);
                  },
                  child: Text(
                    "Cancel",
                    style: ThemingTypography.styleRegular14(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
