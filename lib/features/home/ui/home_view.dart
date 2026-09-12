import 'package:bekia_pay/core/shared/widgets/app_name_widget.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/features/auth/sign_up/data/models/user_model.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:bekia_pay/features/home/logic/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: AppNameWidget(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (message) {
            return Column(
              mainAxisAlignment: .center,
              children: [Text(message).center],
            );
          },
          success: (homeData) {
            final UserModel user = homeData.user;
            final List<OfferModel> offers = homeData.offers;
            return Column(
              mainAxisAlignment: .center,
              children: [
                CarouselSlider(
                  items: [
                    Image.network(offers[0].imageUrl),
                    Image.asset("assets/images/new_offer.jpg"),
                    Image.asset("assets/images/new_offer.jpg"),
                  ],
                  options: CarouselOptions(
                    height: context.screenHeight * .2,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    // onPageChanged: (index, reason) {},
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Text(user.fullName).center,
              ],
            );
          },
        ),
      ),
    );
  }
}
