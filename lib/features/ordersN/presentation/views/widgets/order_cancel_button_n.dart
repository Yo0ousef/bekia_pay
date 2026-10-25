import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/ordersN/presentation/cubit/order_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCancelButtonN extends StatelessWidget {
  final OrderEntity order;

  const OrderCancelButtonN({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final bool afterCancelLimit = now.day >= 25;
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final bool isCancelLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        if (isCancelLoading) {
          return AppConstants.loading;
        } else if (afterCancelLimit) {
          return const SizedBox.shrink();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onPressed: () {
                final cubit = context.read<OrderCubit>();
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text("Canceling your order"),
                    content: const Text("Are you sure you want to cancel?"),
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
