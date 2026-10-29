import 'package:bekia_pay/features/home/domain/entities/offer_entity.dart';
import 'package:flutter/material.dart';

class OfferDetailsView extends StatelessWidget {
  final OfferEntity offer;

  const OfferDetailsView({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.title),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Center(child: Text(offer.description)),
    );
  }
}
