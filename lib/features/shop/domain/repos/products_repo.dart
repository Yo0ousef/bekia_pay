import 'package:bekia_pay/features/shop/domain/entities/product_entity.dart';

abstract class ProductsRepo {
  Future<List<ProductEntity>> getProducts();
}
