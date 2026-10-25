import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/data/models/order_model.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/logic/orders_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCancelButton extends StatelessWidget {
  final OrderModel order;

  const OrderCancelButton({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final bool afterCancelLimit = now.day >= 25;
    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (prev, curr) {
        final prevId = prev.maybeWhen(
          success: (_, id) => id,
          orElse: () => null,
        );
        final currId = curr.maybeWhen(
          success: (_, id) => id,
          orElse: () => null,
        );
        return prevId != currId;
      },
      builder: (context, state) {
        final cancelingId = state.maybeWhen(
          success: (_, id) => id,
          orElse: () => null,
        );
        final bool isCancelLoading = cancelingId == order.id;
        if (isCancelLoading) {
          return AppConstants.loading;
        } else if (afterCancelLimit) {
          return const SizedBox.shrink();
        } else {
          return Padding(
            padding: .symmetric(horizontal: 12.0),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                padding: const .symmetric(horizontal: 12),
              ),
              onPressed: () {
                final cubit = context.read<OrdersCubit>();
                showDialog(
                  context: context,
                  builder: (dialogContext) =>
                      AlertDialog(
                        title: Text("Canceling your order"),
                        content: Text("Are you sure you want to cancel?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: Text(
                              LocaleKeys.cancel.tr(),
                              style: const TextStyle(
                                color: AppColors.secondaryDarkColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              cubit.cancelOrder(order.id);
                              context.read<PointsCubit>().getPoints();
                            },
                            child: Text(
                              LocaleKeys.ok.tr(),
                              style: const TextStyle(color: AppColors.redColor),
                            ),
                          ),
                        ],
                      ),
                );
              },
              child: isCancelLoading
                  ? AppConstants.loading
                  : Text(
                LocaleKeys.cancel.tr(),
                style: ThemingTypography.styleRegular14(context),
              ),
            ),
          );
        }
      },
    );
  }
}
