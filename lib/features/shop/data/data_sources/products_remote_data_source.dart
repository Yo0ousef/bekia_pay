import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/features/shop/data/models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final DatabaseClient databaseClient;

  const ProductsRemoteDataSourceImpl({required this.databaseClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await databaseClient.getData(table: 'products');
    return response.map(ProductModel.fromJson).toList();
  }
}
