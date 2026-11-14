import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/logic/validators.dart';
import 'package:bekia_pay/core/shared/widgets/custom_button.dart';
import 'package:bekia_pay/core/shared/widgets/custom_text_form_field.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/presentation/cubits/forgot_password_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ForgotPasswordCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.forgot_password.tr()),
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.status == ForgotPasswordStatus.failure) {
                Fluttertoast.showToast(
                  msg: state.message ?? LocaleKeys.something_went_wrong.tr(),
                  backgroundColor: AppColors.redColor,
                );
              }
            },
            builder: (context, state) {
              if (state.status == ForgotPasswordStatus.success) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mark_email_read_outlined,
                      size: 64,
                      color: theme.primaryColor,
                    ),
                    24.vGap,
                    Text(
                      LocaleKeys.password_reset_email_sent.tr(),
                      textAlign: TextAlign.center,
                      style: ThemingTypography.styleMedium14(context),
                    ),
                    24.vGap,
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(LocaleKeys.back_to_sign_in.tr()),
                    ),
                  ],
                );
              }

              return Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    32.vGap,
                    Text(
                      LocaleKeys.forgot_password_description.tr(),
                      style: ThemingTypography.styleRegular14(context),
                    ),
                    24.vGap,
                    CustomTextFormField(
                      controller: cubit.emailController,
                      labelText: LocaleKeys.email.tr(),
                      validator: Validators.emailValidate,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    24.vGap,
                    if (state.status == ForgotPasswordStatus.loading)
                      AppConstants.loading
                    else
                      CustomButton(
                        onPressed: cubit.sendResetEmail,
                        text: LocaleKeys.send_reset_email.tr(),
                        width: double.infinity,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
