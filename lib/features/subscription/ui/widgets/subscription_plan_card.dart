import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/subscription/data/models/subscription_model.dart';
import 'package:bekia_pay/features/subscription/logic/subscription_cubit.dart';
import 'package:bekia_pay/features/subscription/ui/widgets/subscription_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionModel plan;
  final Color color;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isAr = context.locale == Locale("ar");
    final prefix = isAr ? 'ar' : 'en';
    final features = plan.features.entries
        .where((entry) => entry.key.toLowerCase().startsWith(prefix))
        .map((entry) => entry.value.toString())
        .toList();

    final title = plan.title[isAr ? 'ar' : 'en']?.toString() ?? '';
    final description = plan.description[isAr ? 'ar' : 'en']?.toString() ?? '';

    final state = context.watch<SubscriptionCubit>().state;
    final bool doesUserHaveAPlan = state.maybeWhen(
      success: (subscriptions, activeSubscriptionId) =>
          activeSubscriptionId != null,
      orElse: () => false,
    );
    final bool isActive = state.maybeWhen(
      success: (subscriptions, activeSubscriptionId) =>
          activeSubscriptionId == plan.id,
      orElse: () => false,
    );

    return Container(
      width: context.screenWidth * .8,
      padding: .all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(24),
        border: (plan.isPopular || isActive)
            ? Border.all(color: color, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withAlpha(50),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (plan.isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    LocaleKeys.most_popular.tr(),
                    style: ThemingTypography.styleBold16(context)
                        .copyWith(color: color, fontSize: 10, letterSpacing: 1),
                  ),
                ),
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    LocaleKeys.active.tr(),
                    style: ThemingTypography.styleBold16(context)
                        .copyWith(color: AppColors.greenColor, fontSize: 10),
                  ),
                ),
            ],
          ),
          12.vGap,
          Text(
            title,
            style: ThemingTypography.styleBold20(context)
                .copyWith(color: color),
          ),
          8.vGap,
          Text(
            "${plan.price}\$ /${LocaleKeys.month.tr()}",
            style: ThemingTypography.styleBold24(context)
                .copyWith(fontSize: 32, color: Colors.black87),
          ),
          if (description.isNotEmpty)
            Text(
              description,
              style: ThemingTypography.styleRegular14(context)
                  .copyWith(color: Colors.black54),
            ),
          8.vGap,
          const Divider(),
          24.vGap,
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: features.length,
              separatorBuilder: (context, index) => 12.vGap,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Icon(Icons.check_circle_rounded, size: 18, color: color),
                    12.hGap,
                    Expanded(
                      child: Text(
                        features[index],
                        style: ThemingTypography.styleRegular14(
                          context,
                        ).copyWith(color: Colors.black54, fontFamily: 'Noto'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          24.vGap,
          SizedBox(
            width: double.infinity,
            height: 50,
            child: isActive
                ? OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: color),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.current_plan.tr(),
                      style: ThemingTypography.styleRegular14(context)
                          .copyWith(color: color),
                    ),
                  )
                : doesUserHaveAPlan
                ? OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: color),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(LocaleKeys.already_have_plan.tr()),
                  )
                : SubscriptionButton(plan: plan, color: color),
          ),
        ],
      ),
    );
  }
}
