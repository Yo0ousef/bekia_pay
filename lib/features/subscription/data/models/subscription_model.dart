import 'package:bekia_pay/features/subscription/domain/entities/subscription_plan_entity.dart';

class SubscriptionModel {
  final String id;
  final Map<String, dynamic> title;
  final int price;
  final Map<String, dynamic> description;
  final Map<String, dynamic> features;
  final bool isPopular;

  const SubscriptionModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    required this.isPopular,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'].toString(),
      title: Map<String, dynamic>.from(json['title'] ?? {}),
      price: (json['price'] as num?)?.toInt() ?? 0,
      description: Map<String, dynamic>.from(json['description'] ?? {}),
      features: Map<String, dynamic>.from(json['features'] ?? {}),
      isPopular: json['is_popular'] ?? false,
    );
  }

  SubscriptionPlanEntity toEntity() => SubscriptionPlanEntity(
    id: id,
    title: title,
    price: price,
    description: description,
    features: features,
    isPopular: isPopular,
  );
}
