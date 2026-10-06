import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OffersRepo {
  Future<ApiResult<List<OfferModel>>> getOffers() async {
    try {
      final offersData = await Supabase.instance.client
          .from("offers")
          .select()
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception(
              'Connection timed out. Please check your internet connection.',
            ),
          );
      final List<OfferModel> offersList = [];
      for (var offer in offersData) {
        offersList.add(OfferModel.fromJson(offer));
      }
      if (offersData.isNotEmpty) {
        return ApiResult.success(offersList);
      } else {
        return ApiResult.failure("something went wrong with offers");
      }
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
