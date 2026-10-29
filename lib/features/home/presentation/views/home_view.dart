import 'package:bekia_pay/features/home/presentation/cubits/home_navigation_cubit.dart';
import 'package:bekia_pay/core/shared/widgets/app_name_widget.dart';
import 'package:bekia_pay/features/cart/logic/cart_count_cubit.dart';
import 'package:bekia_pay/features/chat/ui/chat_view_body.dart';
import 'package:bekia_pay/features/home/presentation/views/widgets/cart_badge.dart';
import 'package:bekia_pay/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:bekia_pay/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:bekia_pay/features/options/ui/options_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = [
      const HomeViewBody(),
      const ChatViewBody(),
      const OptionsView(),
    ];

    ThemeData theme = Theme.of(context);
    return BlocBuilder<HomeNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: state != 2
              ? AppBar(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  title: AppNameWidget(),
                  centerTitle: true,
                  actions: [
                    BlocBuilder<CartCountCubit, int>(
                      builder: (context, count) => CartBadge(count: count),
                    ),
                  ],
                )
              : null,
          body: views[state],
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: state,
            onTap: (index) {
              context.read<HomeNavigationCubit>().changeTab(index);
            },
          ),
        );
      },
    );
  }
}
