class OfferModel {
  String title, description, imageUrl;

  OfferModel(this.title, this.description, this.imageUrl);

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(json["title"], json["description"], json["image_url"]);
  }

}
