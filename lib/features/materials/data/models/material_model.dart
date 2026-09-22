class MaterialModel {
  final String id;
  final String materialName;
  final String materialImage;
  final String materialPoints;

  MaterialModel({
    required this.id,
    required this.materialName,
    required this.materialImage,
    required this.materialPoints,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'].toString(),
      materialName: json['material_name']?.toString() ?? '',
      materialImage: json['material_image']?.toString() ?? '',
      materialPoints: json['material_points']?.toString() ?? '',
    );
  }
}
