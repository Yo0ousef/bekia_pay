import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';

abstract class OffersRemoteDataSource {
  Future<List<OfferModel>> getOffers();
}

class OffersRemoteDataSourceImpl implements OffersRemoteDataSource {
  final DatabaseClient databaseClient;
  OffersRemoteDataSourceImpl({required this.databaseClient});

  @override
  Future<List<OfferModel>> getOffers() async {
    final response = await databaseClient.getData(
          table: 'offers',
          selectQuery: '*',
          orderBy: 'created_at',
          ascending: false,
        ).timeout(5.sec);
    return response.map((json) => OfferModel.fromJson(json)).toList();
  }
}
