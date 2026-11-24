import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/home/presentation/views/widgets/home_card.dart';
import 'package:bekia_pay/features/subscription/presentation/cubits/subscription_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final cubit = context.read<SubscriptionCubit>();
        final subscription = cubit.currentSubscription;
        final hasActivePlan = state.maybeWhen(
          success: (_, activePlanId) =>
          activePlanId != null && subscription?.status == 'active',
          orElse: () => false,
        );
        final remainingSeconds = subscription?.expiresAt
            ?.difference(DateTime.now().toUtc())
            .inSeconds;
        final remainingDays = remainingSeconds != null &&
            remainingSeconds > 0
            ? (remainingSeconds / 86400).ceil()
            : 0;
        final isArabic =
            Localizations
                .localeOf(context)
                .languageCode == 'ar';

        return HomeCard(
          title: LocaleKeys.subscription.tr(),
          trailing: Icon(Icons.verified, color: AppColors.redColor),
          subtitle: hasActivePlan
              ? isArabic
              ? 'الأيام المتبقية: $remainingDays'
              : 'Remaining days: $remainingDays'
              : LocaleKeys.renew.tr(),
          showArrow: !hasActivePlan,
          onTap: () async {
            await Navigator.pushNamed(
              context,
              AppRoutes.subscription.route,
            );
            if (context.mounted) {
              context.read<SubscriptionCubit>().getPlans(
                showLoading: false,
              );
            }
          },
        );
      },
    );
  }
}
