class SubscriptionPlanEntity {
  final String id;
  final Map<String, dynamic> title;
  final int price;
  final Map<String, dynamic> description;
  final Map<String, dynamic> features;
  final bool isPopular;

  const SubscriptionPlanEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    required this.isPopular,
  });
}
