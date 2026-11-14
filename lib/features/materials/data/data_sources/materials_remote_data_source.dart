import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/features/materials/data/models/material_model.dart';

abstract class MaterialsRemoteDataSource {
  Future<List<MaterialModel>> getMaterials();
}

class MaterialsRemoteDataSourceImpl implements MaterialsRemoteDataSource {
  final DatabaseClient databaseClient;

  const MaterialsRemoteDataSourceImpl({required this.databaseClient});

  @override
  Future<List<MaterialModel>> getMaterials() async {
    final response = await databaseClient.getData(table: 'materials');
    return response.map(MaterialModel.fromJson).toList();
  }
}
