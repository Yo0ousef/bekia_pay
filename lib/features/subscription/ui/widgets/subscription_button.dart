import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/subscription/data/models/subscription_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SubscriptionButton extends StatelessWidget {
  const SubscriptionButton({
    super.key,
    required this.plan,
    required this.color,
  });

  final SubscriptionModel plan;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Text(
        LocaleKeys.subscribe.tr(),
        style: ThemingTypography.styleBold16(context)
            .copyWith(color: Colors.white),
      ),
    );
  }
}
