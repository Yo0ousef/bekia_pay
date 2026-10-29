import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> confirmCancellationDialog({
  required BuildContext context,
  required OrdersCubit cubit,
  required OrderEntity order,
  VoidCallback? onCancelled,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(LocaleKeys.cancel_order_confirmation_title.tr()),
      content: Text(LocaleKeys.cancel_order_confirmation_message.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(LocaleKeys.cancel.tr()),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(
            LocaleKeys.ok.tr(),
            style: TextStyle(color: Theme.of(dialogContext).colorScheme.error),
          ),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;

  final cancelled = await cubit.cancelOrder(order.id);
  if (!context.mounted) return;
  if (!cancelled) {
    Fluttertoast.showToast(
      msg: LocaleKeys.order_cancel_failed,
      backgroundColor: AppColors.primaryLightColor,
    );
    return;
  }

  context.read<PointsCubit>().getPoints();
  if (!context.mounted) return;
  if (onCancelled != null) {
    onCancelled();
  } else {
    await cubit.fetchOrders(showLoading: false);
  }
}
