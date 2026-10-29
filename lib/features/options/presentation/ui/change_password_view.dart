import 'package:bekia_pay/app/dependency_injection/dependency_injection.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/shared/logic/validators.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/core/shared/widgets/custom_button.dart';
import 'package:bekia_pay/core/shared/widgets/custom_text_form_field.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/options/presentation/controllers/change_password_form_controller.dart';
import 'package:bekia_pay/features/options/presentation/logic/update_password_cubit/update_password_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.read<ChangePasswordFormController>();
    return BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
      listenWhen: (previous, current) =>
          previous.maybeWhen(loading: () => true, orElse: () => false) &&
          current.maybeWhen(
            success: () => true,
            failure: (_) => true,
            orElse: () => false,
          ),
      listener: (context, state) {
        state.maybeWhen(
          success: () {
            Navigator.of(context).pop(true);
          },
          failure: (message) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.change_password.tr())),
        body: SafeArea(
          child: Form(
            key: form.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                BlocProvider(
                  create: (_) => DependencyInjection.getIt<VisibilityCubit>(),
                  child: BlocBuilder<VisibilityCubit, bool>(
                    builder: (context, isObscured) => CustomTextFormField(
                      labelText: LocaleKeys.current_password.tr(),
                      controller: form.currentPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscured,
                      validator: Validators.emptyValidate,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.disableDarkColor,
                        ),
                        onPressed: context
                            .read<VisibilityCubit>()
                            .toggleVisibility,
                      ),
                    ),
                  ),
                ),
                12.vGap,
                BlocProvider(
                  create: (_) => DependencyInjection.getIt<VisibilityCubit>(),
                  child: BlocBuilder<VisibilityCubit, bool>(
                    builder: (context, isObscured) => CustomTextFormField(
                      labelText: LocaleKeys.password.tr(),
                      controller: form.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscured,
                      validator: Validators.passwordValidate,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.disableDarkColor,
                        ),
                        onPressed: context
                            .read<VisibilityCubit>()
                            .toggleVisibility,
                      ),
                    ),
                  ),
                ),
                12.vGap,
                BlocProvider(
                  create: (_) => DependencyInjection.getIt<VisibilityCubit>(),
                  child: BlocBuilder<VisibilityCubit, bool>(
                    builder: (context, isObscured) => CustomTextFormField(
                      labelText: LocaleKeys.confirm_password.tr(),
                      controller: form.confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscured,
                      validator: (value) {
                        if (value != form.passwordController.text) {
                          return LocaleKeys.passwords_do_not_match.tr();
                        }
                        return Validators.passwordValidate(value);
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.disableDarkColor,
                        ),
                        onPressed: context
                            .read<VisibilityCubit>()
                            .toggleVisibility,
                      ),
                    ),
                  ),
                ),
                20.vGap,
                BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                    return SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        width: double.infinity,
                        onPressed: isLoading
                            ? null
                            : () {
                                if (!form.formKey.currentState!.validate()) {
                                  return;
                                }
                                context
                                    .read<UpdatePasswordCubit>()
                                    .updatePassword(
                                      currentPassword:
                                          form.currentPasswordController.text,
                                      newPassword: form.passwordController.text,
                                    );
                              },
                        text: LocaleKeys.ok.tr(),
                        widget: isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
