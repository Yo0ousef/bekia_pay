import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/shared/widgets/custom_button.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/widgets/auth_header.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/widgets/new_acc_or_login.dart';
import 'package:bekia_pay/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:bekia_pay/features/auth/sign_up/ui/widgets/sign_up_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final signUpCubit = context.read<SignUpCubit>();
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: .all(24),
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  AuthHeader(
                    title: LocaleKeys.hello_get_started.tr(),
                    description: LocaleKeys.create_and_join.tr(),
                    imagePath: ImageConstants.avatar,
                  ),
                  75.vGap,
                  SignUpForm(),
                  25.vGap,
                  Center(
                    child: BlocConsumer<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success: () => Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signIn.route,
                          ),
                          failure: (message) {
                            Fluttertoast.showToast(
                              msg: LocaleKeys.something_went_wrong.tr(),
                              backgroundColor: AppColors.redColor,
                              textColor: AppColors.whiteColor,
                              fontSize: 16,
                            );
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () => AppConstants.loading,
                          orElse: () {
                            return CustomButton(
                              onPressed: signUpCubit.signUp,
                              text: LocaleKeys.sign_up.tr(),
                              width: .infinity,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  25.vGap,
                  NewAccOrLogin(
                    haveOrNot: LocaleKeys.already_have_account.tr(),
                    loginOrCreate: LocaleKeys.sign_in.tr(),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signIn.route);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
