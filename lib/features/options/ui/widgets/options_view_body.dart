import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/features/options/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:bekia_pay/features/options/ui/widgets/options_list_view_body.dart';
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
                      orElse: () {
                        final spinKit = SpinKitWave(
                          color: AppColors.disableDarkColor,
                          size: 30.0,
                        );
                        return spinKit;
                      },
                      success: (data) {
                        return Text(
                          data['full_name'],
                          style: ThemingTypography.styleBold24(context)
                              .copyWith(color: AppColors.blackColor),
                        );
                      },
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
