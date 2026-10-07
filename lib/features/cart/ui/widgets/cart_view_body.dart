import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/cart/ui/widgets/cart_check_out_button.dart';
import 'package:bekia_pay/features/cart/ui/widgets/cart_items_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.disableDarkColor,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            color: AppColors.yellowColor,
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.warning_amber, color: AppColors.redColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  LocaleKeys.cart_warning_message.tr(),
                  style: ThemingTypography.styleRegular14(context)
                      .copyWith(color: AppColors.blackColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: CartItemsList()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: const Divider(),
        ),
        CartCheckOutButton(),
      ],
    );
  }
}
