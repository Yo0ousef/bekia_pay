import 'package:bekia_pay/features/materials/data/data_sources/materials_remote_data_source.dart';
import 'package:bekia_pay/features/materials/domain/entities/material_entity.dart';
import 'package:bekia_pay/features/materials/domain/repos/materials_repo.dart';

class MaterialsRepoImpl implements MaterialsRepo {
  final MaterialsRemoteDataSource remoteDataSource;

  const MaterialsRepoImpl(this.remoteDataSource);

  @override
  Future<List<MaterialEntity>> getMaterials() async {
    final models = await remoteDataSource.getMaterials();
    return models.map((model) => model.toEntity()).toList();
  }
}
