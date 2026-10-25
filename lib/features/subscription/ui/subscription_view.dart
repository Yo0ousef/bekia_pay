import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/widgets/reload.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/subscription/logic/subscription_cubit.dart';
import 'package:bekia_pay/features/subscription/ui/widgets/subscription_plan_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.subscription_plans.tr()),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
          return state.when(
            loading: () => AppConstants.loading.center,
            success: (plans, activePlanId) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: .all(24.0),
                      child: Text(
                        LocaleKeys.choose_plan.tr(),
                        style: ThemingTypography.styleBold24(context),
                      ),
                    ),
                    SizedBox(
                      height: context.screenHeight * .7,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(30),
                        itemCount: plans.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          return SubscriptionPlanCard(
                            plan: plans[index],
                            color: AppColors.primaryLightColor,
                          );
                        },
                      ),
                    ),
                    48.vGap,
                  ],
                ),
              );
            },
            failure: (_) {
              return Reload(
                onTap: () {
                  context.read<SubscriptionCubit>().getPlans();
                },
              );
            },
          );
        },
      ),
    );
  }
}
