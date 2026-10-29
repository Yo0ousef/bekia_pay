import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: LocaleKeys.home.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: LocaleKeys.chat.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: LocaleKeys.more.tr(),
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
      unselectedItemColor: AppColors.disableDarkColor,

      selectedItemColor: AppColors.redColor,
    );
  }
}
