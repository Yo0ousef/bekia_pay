import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/core/shared/widgets/custom_button.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/on_boarding/presentation/cubits/boarding_cubit.dart';
import 'package:bekia_pay/features/on_boarding/presentation/views/widgets/on_boarding_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<BoardingCubit, BoardingState>(
      builder: (context, state) {
        return Column(
          children: [
            OnBoardingPageView(
              pageController: context.read<BoardingCubit>().pageController,
            ).expanded,
            DotsIndicator(
              dotsCount: 4,
              position: context.read<BoardingCubit>().currentPage,
              decorator: DotsDecorator(
                color: theme.primaryColor.withAlpha(100),
                activeSize: Size(12, 12),
                activeColor: theme.primaryColor,
              ),
            ),
            20.vGap,
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: context.read<BoardingCubit>().currentPage == 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding,
                ),
                child: CustomButton(
                  width: double.infinity,
                  onPressed: () {
                    Prefs.setBool(AppConstants.seenBoarding, true);
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.signIn.route,
                    );
                  },
                  text: LocaleKeys.get_started.tr(),
                ),
              ),
            ),
            40.vGap,
          ],
        );
      },
    );
  }
}
