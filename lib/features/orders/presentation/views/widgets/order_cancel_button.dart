import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/presentation/cubit/order_cubit.dart';
import 'package:bekia_pay/features/orders/presentation/utils/order_ui_rules.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/confirm_cancellation_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCancelButton extends StatelessWidget {
  final OrderEntity order;
  final bool compact;
  final VoidCallback? onCancelled;

  const OrderCancelButton({
    super.key,
    required this.order,
    this.compact = false,
    this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOrderCancelableInUi(order, DateTime.now())) {
      return const SizedBox.shrink();
    }

    final cubit = context.read<OrderCubit>();
    return ValueListenableBuilder<String?>(
      valueListenable: cubit.cancellingOrderId,
      builder: (context, cancellingId, _) {
        final isThisOrderLoading = cancellingId == order.id;
        final anotherOrderIsLoading =
            cancellingId != null && cancellingId != order.id;
        final onPressed = anotherOrderIsLoading
            ? null
            : () => confirmCancellationDialog(
                context: context,
                cubit: cubit,
                order: order,
                onCancelled: onCancelled,
              );

        if (compact) {
          return IconButton(
            tooltip: LocaleKeys.cancel.tr(),
            onPressed: onPressed,
            icon: isThisOrderLoading
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    Icons.cancel_outlined,
                    color: Theme.of(context).colorScheme.error,
                  ),
          );
        }

        return TextButton.icon(
          onPressed: onPressed,
          icon: isThisOrderLoading
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.cancel_outlined),
          label: Text(LocaleKeys.cancel.tr()),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
    );
  }
}
