import 'package:bekia_pay/features/home/domain/entities/offer_entity.dart';
import 'package:bekia_pay/features/home/domain/repos/offers_repo.dart';

class GetOffersUseCase {
  final OffersRepo repository;

  GetOffersUseCase({required this.repository});

  Future<List<OfferEntity>> call() async {
    return await repository.getOffers();
  }
}
