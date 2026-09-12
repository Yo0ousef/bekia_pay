import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/auth/sign_up/data/models/user_model.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepo {
  Future<ApiResult<UserModel>> getUser() async {
    final session = Supabase.instance.client.auth.currentSession;
    try {
      final userData = await Supabase.instance.client
          .from("profiles")
          .select()
          .eq("id", session!.user.id);
      if (userData.isNotEmpty) {
        return ApiResult.success(UserModel.fromJson(userData[0]));
      } else {
        return ApiResult.failure("something went wrong with user");
      }
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<ApiResult<List<OfferModel>>> getOffers() async {
    try {
      final offersData = await Supabase.instance.client.from("offers").select();
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
