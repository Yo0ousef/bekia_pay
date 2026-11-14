import 'package:bekia_pay/features/materials/domain/entities/material_entity.dart';

abstract class MaterialsRepo {
  Future<List<MaterialEntity>> getMaterials();
}
