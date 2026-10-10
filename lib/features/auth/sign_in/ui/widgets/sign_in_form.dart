import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/logic/validators.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/core/shared/widgets/custom_button.dart';
import 'package:bekia_pay/core/shared/widgets/custom_text_form_field.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/widgets/new_acc_or_login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final SignInCubit cubit = context.read<SignInCubit>();
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        state.maybeWhen(
          success: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home.route,
                  (route) => false,
            );
          },
          failure: (message) {
            Fluttertoast.showToast(
              msg: message,
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
              fontSize: 16,
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Form(
          key: cubit.formKey,
          autovalidateMode: .onUnfocus,
          child: Column(
            children: [
              CustomTextFormField(
                onSaved: cubit.onEmailSaved,
                labelText: LocaleKeys.email.tr(),
                controller: cubit.emailController,
                validator: Validators.emailValidate,
                keyboardType: TextInputType.emailAddress,
              ),
              16.vGap,
              BlocBuilder<VisibilityCubit, bool>(
                builder: (context, state) {
                  return CustomTextFormField(
                    controller: cubit.passwordController,
                    onSaved: cubit.onPasswordSaved,
                    validator: Validators.passwordValidate,
                    labelText: LocaleKeys.password.tr(),
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.disableDarkColor,
                      ),
                      onPressed: context
                          .read<VisibilityCubit>()
                          .toggleVisibility,
                    ),
                    obscureText: state,
                  );
                },
              ),
              14.vGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    LocaleKeys.forgot_password.tr(),
                    style: ThemingTypography.styleRegular14(context)
                        .copyWith(color: theme.primaryColor),
                  ),
                ],
              ),
              20.vGap,
              state.maybeWhen(
                loading: () {
                  return AppConstants.loading;
                },
                orElse: () {
                  return CustomButton(
                    onPressed: cubit.signIn,
                    text: LocaleKeys.sign_in.tr(),
                    width: double.infinity,
                  );
                },
              ),
              20.vGap,
              NewAccOrLogin(
                haveOrNot: LocaleKeys.do_not_have_an_account.tr(),
                loginOrCreate: LocaleKeys.create_new_account.tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.signUp.route);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
