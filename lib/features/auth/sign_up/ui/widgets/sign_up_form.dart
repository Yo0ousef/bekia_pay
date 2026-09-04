import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/dependency_injection/dependency_injection.dart';
import 'package:bekia_pay/core/shared/logic/validators.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/core/shared/widgets/custom_text_form_field.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_text_field/phone_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();
    return Form(
      key: signUpCubit.formKey,
      autovalidateMode: .onUnfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            labelText: LocaleKeys.name.tr(),
            controller: signUpCubit.nameController,
            validator: Validators.emptyValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.name,
          ),
          10.vGap,
          CustomTextFormField(
            labelText: LocaleKeys.email.tr(),
            controller: signUpCubit.emailController,
            validator: Validators.emailValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.emailAddress,
          ),
          10.vGap,
          PhoneTextField(
            initialCountryCode: 'SA',
            onChanged: signUpCubit.onPhoneNumberChanged,
            decoration: InputDecoration(
              labelText: LocaleKeys.phone_number.tr(),
              labelStyle: ThemingTypography.styleRegular20(context),
            ),
          ),
          10.vGap,
          CustomTextFormField(
            labelText: LocaleKeys.governorate.tr(),
            controller: signUpCubit.governorateController,
            validator: Validators.emptyValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.text,
          ),
          10.vGap,
          CustomTextFormField(
            labelText: LocaleKeys.city.tr(),
            controller: signUpCubit.cityController,
            validator: Validators.emptyValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.text,
          ),
          10.vGap,
          CustomTextFormField(
            labelText: LocaleKeys.street.tr(),
            controller: signUpCubit.streetController,
            validator: Validators.emptyValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.text,
          ),
          10.vGap,
          CustomTextFormField(
            labelText: LocaleKeys.house_number.tr(),
            controller: signUpCubit.houseNumberController,
            validator: Validators.emptyValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.text,
          ),
          10.vGap,
          CustomTextFormField(
            labelText: LocaleKeys.floor.tr(),
            controller: signUpCubit.floorController,
            validator: Validators.numbersValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.number,
          ),
          10.vGap,
          CustomTextFormField(
            labelText: LocaleKeys.apartment_number.tr(),
            controller: signUpCubit.apartmentNumberController,
            validator: Validators.numbersValidate,
            onSaved: signUpCubit.onNameSaved,
            keyboardType: TextInputType.number,
          ),
          10.vGap,
          BlocProvider(
            create: (context) => DependencyInjection.getIt<VisibilityCubit>(),
            child: BlocBuilder<VisibilityCubit, bool>(
              builder: (context, state) {
                return CustomTextFormField(
                  labelText: LocaleKeys.password.tr(),
                  controller: signUpCubit.passwordController,
                  validator: Validators.passwordValidate,
                  onSaved: signUpCubit.onNameSaved,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: state,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.disableDarkColor,
                    ),
                    onPressed: context.read<VisibilityCubit>().toggleVisibility,
                  ),
                );
              },
            ),
          ),
          10.vGap,
          BlocProvider(
            create: (context) => DependencyInjection.getIt<VisibilityCubit>(),
            child: BlocBuilder<VisibilityCubit, bool>(
              builder: (context, state) {
                return CustomTextFormField(
                  labelText: LocaleKeys.confirm_password.tr(),
                  controller: signUpCubit.confirmPasswordController,
                  validator: Validators.passwordValidate,
                  onSaved: signUpCubit.onNameSaved,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: state,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.disableDarkColor,
                    ),
                    onPressed: context.read<VisibilityCubit>().toggleVisibility,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
