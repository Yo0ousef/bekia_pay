import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:bekia_pay/features/subscription/presentation/cubits/subscription_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionButton extends StatefulWidget {
  const SubscriptionButton({
    super.key,
    required this.plan,
    required this.color,
    this.isCancelRequest = false,
  });

  final SubscriptionPlanEntity plan;
  final Color color;
  final bool isCancelRequest;

  @override
  State<SubscriptionButton> createState() => _SubscriptionButtonState();
}

class _SubscriptionButtonState extends State<SubscriptionButton> {
  bool _isLoading = false;

  Future<void> _subscribe() async {
    setState(() => _isLoading = true);
    String message;
    try {
      if (widget.isCancelRequest) {
        await context.read<SubscriptionCubit>().cancelRequest();
        message = 'Subscription request cancelled.';
      } else {
        await context.read<SubscriptionCubit>().subscribe(widget.plan.id);
        message = 'Subscription request placed. Pay cash on delivery.';
      }
    } catch (error, stackTrace) {
      debugPrint('Subscription request failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      message = 'Could not place subscription request: $error';
    }
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _subscribe,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.whiteColor,
              ),
            )
          : Text(
              widget.isCancelRequest
                  ? LocaleKeys.cancel.tr()
                  : LocaleKeys.subscribe.tr(),
              style: ThemingTypography.styleBold16(context)
                  .copyWith(color: AppColors.whiteColor),
            ),
    );
  }
}
