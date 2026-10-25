import 'package:bekia_pay/core/shared/widgets/reload_button.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Reload extends StatelessWidget {
  final VoidCallback onTap;

  const Reload({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(LocaleKeys.something_went_wrong.tr()),
        12.vGap,
        ReloadButton(
          onTap: onTap,
        ),
      ],
    ).center;
  }
}
