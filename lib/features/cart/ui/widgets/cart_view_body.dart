import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/logic/check_out_cubit/check_out_cubit.dart';
import 'package:bekia_pay/features/cart/ui/widgets/cart_items_list.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
          padding: const .all(16.0),
          child: BlocBuilder<CartCubit, List<CartItemModel>>(
            builder: (context, cartItems) {
              if (cartItems.isEmpty) return const SizedBox.shrink();
              return BlocBuilder<CheckOutCubit, CheckOutState>(
                builder: (context, checkoutState) {
                  final totalPoints = context.read<CartCubit>().totalPoints;
                  final isAfterLimit = DateTime.now().day >= 25;
                  return BlocBuilder<PointsCubit, PointsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return CircularProgressIndicator(
                            color: theme.primaryColor,
                          );
                        },
                        success: (points) {
                          final num userPoints = points;
                          final isInsufficient = (userPoints < totalPoints);
                          final bool isDisabled =
                              isAfterLimit ||
                              checkoutState.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              );
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAfterLimit
                                  ? AppColors.disableDarkColor
                                  : AppColors.primaryLightColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: isDisabled
                                ? null
                                : () {
                                    if (isInsufficient) {
                                      Fluttertoast.showToast(
                                        msg: "Insufficient",
                                      );
                                    } else {
                                      context.read<CheckOutCubit>().checkOut(
                                        items: cartItems,
                                      );
                                    }
                                  },
                            child: Text(
                              "${LocaleKeys.materials.tr()} $totalPoints",
                            ),
                          );
                        },
                        orElse: () {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAfterLimit
                                  ? AppColors.disableDarkColor
                                  : AppColors.primaryLightColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "${LocaleKeys.materials.tr()} $totalPoints",
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
