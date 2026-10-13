import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/options/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:bekia_pay/features/options/ui/widgets/option_tile.dart';
import 'package:bekia_pay/features/options/ui/widgets/show_language_dialoge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OptionsListViewBody extends StatelessWidget {
  const OptionsListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        optionTile(
          context,
          icon: Icons.history,
          title: LocaleKeys.my_orders.tr(),
          onTap: () {
            // Navigator.pushNamed(context, ActivityHistoryView.routeName);
          },
        ),
        optionTile(
          context,
          icon: Icons.favorite_border,
          title: LocaleKeys.favourites.tr(),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.favourites.route);
          },
        ),
        optionTile(
          context,
          icon: Icons.settings,
          title: LocaleKeys.profile.tr(),
          onTap: () {
            // Navigator.pushNamed(context, AccountSettingsView.routeName);
          },
        ),
        optionTile(
          context,
          icon: Icons.password,
          title: LocaleKeys.change_password.tr(),
          onTap: () {
            // Navigator.pushNamed(context, ChangePasswordView.routeName);
          },
        ),
        optionTile(
          context,
          icon: Icons.help_outline,
          title: LocaleKeys.help_center.tr(),
          onTap: () {},
        ),
        optionTile(
          context,
          icon: Icons.language,
          title: LocaleKeys.language.tr(),
          onTap: () {
            showLanguageDialog(context);
          },
        ),
        optionTile(
          context,
          icon: Icons.chat_outlined,
          title: LocaleKeys.contact_us.tr(),
          onTap: () {},
        ),
        BlocConsumer<SignOutCubit, SignOutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.signIn.route,
                  (route) => false,
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return ListTile(
                  onTap: () {
                    context.read<SignOutCubit>().signOut();
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.logout, color: AppColors.redColor),
                  title: Text(
                    LocaleKeys.sign_out.tr(),
                    style: ThemingTypography.styleBold20(context)
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                );
              },
              loading: () {
                const spinKit = Padding(
                  padding: .all(8.0),
                  child: SpinKitCircle(color: AppColors.redColor, size: 25.0),
                );
                return spinKit;
              },
            );
          },
        ),
      ],
    );
  }
}
