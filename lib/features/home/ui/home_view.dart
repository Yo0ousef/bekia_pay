import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/core/shared/logic/cubits/slider_cubit.dart';
import 'package:bekia_pay/core/shared/widgets/app_name_widget.dart';
import 'package:bekia_pay/features/chat/ui/chat_view_body.dart';
import 'package:bekia_pay/features/home/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:bekia_pay/features/home/ui/widgets/home_view_body.dart';
import 'package:bekia_pay/features/options/ui/options_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = [
      const HomeViewBody(),
      const ChatViewBody(),
      const OptionsViewBody(),
    ];

    ThemeData theme = Theme.of(context);
    return BlocBuilder<IndexChangerCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: state != 2
              ? AppBar(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  title: AppNameWidget(),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.cart.route);
                      },
                      icon: Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                )
              : null,
          body: views[context.read<IndexChangerCubit>().state],
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: state,
            onTap: (index) {
              context.read<IndexChangerCubit>().changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
