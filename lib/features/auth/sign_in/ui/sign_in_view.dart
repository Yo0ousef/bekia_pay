import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/widgets/auth_header.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/widgets/sign_in_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: .symmetric(horizontal: AppConstants.horizontalPadding),
            child: Column(
              children: [
                AuthHeader(
                  title: LocaleKeys.welcome_back.tr(),
                  description: LocaleKeys.happy_to_see_you.tr(),
                  imagePath: ImageConstants.avatar,
                ),
                100.vGap,
                SignInForm(),
              ],
            ),
          ),
        ).center,
      ),
    );
  }
}
