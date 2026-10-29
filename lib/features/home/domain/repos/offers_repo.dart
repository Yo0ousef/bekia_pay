import 'package:bekia_pay/features/home/domain/entities/offer_entity.dart';

abstract class OffersRepo {
  Future<List<OfferEntity>> getOffers();
}
