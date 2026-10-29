import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      String selectedLanguage =
          Localizations.localeOf(context).languageCode == 'ar' ? 'ar' : 'en';
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              LocaleKeys.language.tr(),
              style: ThemingTypography.styleBold20(context),
            ),
            content: RadioGroup(
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) {
                  setDialogState(() {
                    selectedLanguage = value;
                  });
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('English'),
                    value: 'en',
                    activeColor: AppColors.secondaryDarkColor,
                  ),
                  RadioListTile<String>(
                    title: const Text('العربية'),
                    value: 'ar',
                    activeColor: AppColors.secondaryDarkColor,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.redColor.withAlpha(200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: const TextStyle(color: AppColors.whiteColor),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryLightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.setLocale(Locale(selectedLanguage));
                  Navigator.pop(context);
                  // Restart.restartApp(
                  //   notificationTitle: 'Restarting App',
                  //   notificationBody: 'Please tap here to open the app again.',
                  // );
                },
                child: Text(
                  LocaleKeys.ok.tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
