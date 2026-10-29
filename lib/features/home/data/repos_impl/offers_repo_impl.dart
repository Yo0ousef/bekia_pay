import 'package:bekia_pay/features/home/data/data_sources/offers_remote_data_source.dart';
import 'package:bekia_pay/features/home/domain/entities/offer_entity.dart';
import 'package:bekia_pay/features/home/domain/repos/offers_repo.dart';

class OffersRepoImpl implements OffersRepo {
  final OffersRemoteDataSource remoteDataSource;

  OffersRepoImpl(this.remoteDataSource);

  @override
  Future<List<OfferEntity>> getOffers() async {
    final response = await remoteDataSource.getOffers();
    return response.map((model) => model.toEntity()).toList();
  }
}
