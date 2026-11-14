import 'dart:async';

import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/widgets/product_image.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bekia_pay/features/cart/presentation/logic/cart_cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewItem extends StatelessWidget {
  final CartItemEntity item;

  const CartViewItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 132),
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
          ProductImage(imageUrl: item.imageUrl),
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
                "${LocaleKeys.amount.tr()} : ${item.quantity}",
                style: ThemingTypography.styleRegular12(context),
              ),
              Text(
                "${LocaleKeys.price.tr()} : ${item.pricePoints}",
                style: ThemingTypography.styleRegular12(context),
              ),
              Text(
                "${LocaleKeys.total.tr()} : ${item.quantity * item.pricePoints}",
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
                  unawaited(context.read<CartCubit>().removeItem(item));
                },
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: ThemingTypography.styleRegular14(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
