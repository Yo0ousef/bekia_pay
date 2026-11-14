import 'package:bekia_pay/features/shop/domain/entities/product_entity.dart';
import 'package:bekia_pay/features/shop/domain/repos/products_repo.dart';

class GetProductsUseCase {
  final ProductsRepo repository;

  const GetProductsUseCase({required this.repository});

  Future<List<ProductEntity>> call() => repository.getProducts();
}
