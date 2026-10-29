import 'package:bekia_pay/core/shared/logic/validators.dart';
import 'package:bekia_pay/core/shared/widgets/custom_button.dart';
import 'package:bekia_pay/core/shared/widgets/custom_text_form_field.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/options/presentation/controllers/edit_profile_form_controller.dart';
import 'package:bekia_pay/features/options/presentation/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_text_field/phone_text_field.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.read<EditProfileFormController>();
    return BlocListener<UserProfileCubit, UserProfileState>(
      listenWhen: (previous, current) =>
          previous.maybeWhen(updating: () => true, orElse: () => false) &&
          current.maybeWhen(
            success: (_) => true,
            failure: (_) => true,
            orElse: () => false,
          ),
      listener: (context, state) {
        state.maybeWhen(
          success: (_) {
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
        appBar: AppBar(title: Text(LocaleKeys.profile.tr())),
        body: SafeArea(
          child: Form(
            key: form.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomTextFormField(
                  labelText: LocaleKeys.name.tr(),
                  controller: form.nameController,
                  keyboardType: TextInputType.name,
                  validator: Validators.emptyValidate,
                ),
                12.vGap,
                PhoneTextField(
                  initialCountryCode: 'SA',
                  initialValue: form.phone,
                  onChanged: (phoneNumber) {
                    form.phone = phoneNumber.completeNumber;
                  },
                  decoration: InputDecoration(
                    labelText: LocaleKeys.phone_number.tr(),
                  ),
                ),
                12.vGap,
                CustomTextFormField(
                  labelText: LocaleKeys.governorate.tr(),
                  controller: form.governorateController,
                  keyboardType: TextInputType.text,
                ),
                12.vGap,
                CustomTextFormField(
                  labelText: LocaleKeys.city.tr(),
                  controller: form.cityController,
                  keyboardType: TextInputType.text,
                ),
                12.vGap,
                CustomTextFormField(
                  labelText: LocaleKeys.street.tr(),
                  controller: form.streetController,
                  keyboardType: TextInputType.text,
                ),
                12.vGap,
                CustomTextFormField(
                  labelText: LocaleKeys.house_number.tr(),
                  controller: form.houseNumberController,
                  keyboardType: TextInputType.text,
                ),
                12.vGap,
                CustomTextFormField(
                  labelText: LocaleKeys.floor.tr(),
                  controller: form.floorController,
                  keyboardType: TextInputType.number,
                  validator: Validators.numbersValidate,
                ),
                12.vGap,
                CustomTextFormField(
                  labelText: LocaleKeys.apartment_number.tr(),
                  controller: form.apartmentNumberController,
                  keyboardType: TextInputType.number,
                  validator: Validators.numbersValidate,
                ),
                20.vGap,
                BlocBuilder<UserProfileCubit, UserProfileState>(
                  builder: (context, state) {
                    final isUpdating = state.maybeWhen(
                      updating: () => true,
                      orElse: () => false,
                    );
                    return SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        width: double.infinity,
                        onPressed: isUpdating
                            ? null
                            : () {
                                if (!form.formKey.currentState!.validate()) {
                                  return;
                                }
                                context
                                    .read<UserProfileCubit>()
                                    .updateUserProfile(form.toUpdatedEntity());
                              },
                        text: LocaleKeys.ok.tr(),
                        widget: isUpdating
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
