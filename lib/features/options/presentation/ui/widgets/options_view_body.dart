import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/options/presentation/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:bekia_pay/features/options/presentation/ui/widgets/options_list_view_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OptionsViewBody extends StatelessWidget {
  const OptionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: .symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<UserProfileCubit, UserProfileState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      success: (user) => Text(
                          user.fullName,
                          style: ThemingTypography.styleBold24(context)
                              .copyWith(color: AppColors.blackColor),
                        ),
                      failure: (_) => IconButton(
                        tooltip: LocaleKeys.something_went_wrong.tr(),
                        onPressed: () => context
                            .read<UserProfileCubit>()
                            .fetchUserProfile(),
                        icon: const Icon(Icons.refresh),
                      ),
                      orElse: () => SpinKitWave(
                        color: AppColors.disableDarkColor,
                        size: 30,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    size: 30,
                    color: AppColors.disableDarkColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Divider(color: AppColors.disableLightColor, thickness: 1),
            Expanded(child: OptionsListViewBody()),
          ],
        ),
      ),
    );
  }
}
