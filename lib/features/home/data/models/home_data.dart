import 'package:bekia_pay/features/auth/sign_up/data/models/user_model.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';

class HomeData {
  final UserModel user;
  final List<OfferModel> offers;

  const HomeData({
    required this.user,
    required this.offers,
  });
}