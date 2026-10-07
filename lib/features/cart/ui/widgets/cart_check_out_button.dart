import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/logic/check_out_cubit/check_out_cubit.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartCheckOutButton extends StatelessWidget {
  const CartCheckOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: BlocBuilder<CartCubit, List<CartItemModel>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) return const SizedBox.shrink();
          return BlocConsumer<CheckOutCubit, CheckOutState>(
            listener: (context, checkoutState) {
              checkoutState.whenOrNull(
                success: () {
                  context.read<CartCubit>().clearCart();
                  context.read<PointsCubit>().getPoints();
                  context.read<CheckOutCubit>().reset();
                  Fluttertoast.showToast(
                    msg: LocaleKeys.order_placed.tr(),
                    backgroundColor: theme.primaryColor,
                  );
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                failure: (message) {
                  context.read<CheckOutCubit>().reset();
                  Fluttertoast.showToast(
                    msg: message,
                    backgroundColor: AppColors.redColor,
                  );
                },
              );
            },
            builder: (context, checkoutState) {
              final totalPoints = context.read<CartCubit>().totalPoints;
              final isAfterLimit = DateTime.now().day >= 25;
              final bool isLoading = checkoutState.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );
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
                      final bool isDisabled = isAfterLimit || isLoading;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: LocaleKeys.pay_total_of.tr(),
                                  style: TextStyle(color: AppColors.blackColor),
                                ),
                                TextSpan(
                                  text: " ${totalPoints.toString()} ",
                                  style: TextStyle(color: AppColors.redColor),
                                ),
                                TextSpan(
                                  text: LocaleKeys.points.tr(),
                                  style: TextStyle(color: AppColors.blackColor),
                                ),
                              ],
                            ),
                          ),
                          4.vGap,
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: LocaleKeys.you_have.tr(),
                                  style: TextStyle(color: AppColors.blackColor),
                                ),
                                TextSpan(
                                  text: " ${userPoints.toString()} ",
                                  style: TextStyle(color: AppColors.greenColor),
                                ),
                                TextSpan(
                                  text: LocaleKeys.points.tr(),
                                  style: TextStyle(color: AppColors.blackColor),
                                ),
                              ],
                            ),
                          ),
                          8.vGap,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
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
                                          msg: LocaleKeys.insufficient_points
                                              .tr(),
                                        );
                                      } else {
                                        context.read<CheckOutCubit>().checkOut(
                                          items: cartItems,
                                        );
                                      }
                                    },
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.whiteColor,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(LocaleKeys.order_now.tr()),
                            ),
                          ),
                        ],
                      );
                    },
                    orElse: () {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
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
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
