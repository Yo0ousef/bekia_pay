import 'package:bekia_pay/core/utils/extensions/json_parser_extension.dart';
import 'package:bekia_pay/features/home/domain/entities/offer_entity.dart';

class OfferModel {
  final String title;
  final String description;
  final String imageUrl;

  const OfferModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    const ctx = 'offers';
    return OfferModel(
      title: json.parseRequiredString("title", contextName: ctx),
      description: json.parseRequiredString("description", contextName: ctx),
      imageUrl: json.parseRequiredString("image_url", contextName: ctx),
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "image_url": imageUrl};
  }

  OfferEntity toEntity() {
    return OfferEntity(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
