import 'package:bekia_pay/features/materials/domain/entities/material_entity.dart';
import 'package:bekia_pay/features/materials/domain/repos/materials_repo.dart';

class GetMaterialsUseCase {
  final MaterialsRepo repository;

  const GetMaterialsUseCase({required this.repository});

  Future<List<MaterialEntity>> call() => repository.getMaterials();
}
