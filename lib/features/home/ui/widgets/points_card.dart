import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final double width = context.screenWidth * .45;
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: .circular(15),
          border: Border.all(color: AppColors.blackColor.withValues(alpha: .1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .3),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        width: width,
        height: context.screenHeight * .13,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  LocaleKeys.my_points.tr(),
                  style: ThemingTypography.styleRegular14(context).copyWith(
                    color: theme != .dark
                        ? AppColors.secondaryLightColor
                        : AppColors.secondaryDarkColor,
                  ),
                ),
              ],
            ),
            10.vGap,
            Row(
              mainAxisAlignment: .center,
              children: [
                BlocBuilder<PointsCubit, PointsState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () {
                        return CircularProgressIndicator(
                          color: theme.primaryColor,
                        ).center;
                      },
                      success: (points) {
                        return Text(points.toString());
                      },
                      failure: (_) {
                        return InkWell(
                          onTap: () {
                            context.read<PointsCubit>().getPoints();
                          },
                          child: Icon(
                            Icons.refresh,
                            color: AppColors.redColor,
                          ).center,
                        );
                      },
                    );
                  },
                ),
                10.hGap,
                Icon(Icons.stars, color: AppColors.redColor, size: 22),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
