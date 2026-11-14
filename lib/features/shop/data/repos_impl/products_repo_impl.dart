import 'package:bekia_pay/features/shop/data/data_sources/products_remote_data_source.dart';
import 'package:bekia_pay/features/shop/domain/entities/product_entity.dart';
import 'package:bekia_pay/features/shop/domain/repos/products_repo.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;

  const ProductsRepoImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final models = await remoteDataSource.getProducts();
    return models.map((model) => model.toEntity()).toList();
  }
}
