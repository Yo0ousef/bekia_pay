import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/shop/data/models/product_model.dart';
import 'package:bekia_pay/features/shop/data/products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_cubit.freezed.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;

  ProductsCubit(this._productsRepo) : super(const ProductsState.loading()) {
    getProducts();
  }

  void getProducts() async {
    final ApiResult<List<ProductModel>> products = await _productsRepo
        .getProducts();
    products.when(
      success: (products) => emit(ProductsState.success(products)),
      failure: (message) => emit(ProductsState.failure(message)),
    );
  }

  void updateLocalQuantity(String productId, int quantity) {
    state.maybeWhen(
      orElse: () => null,
      success: (products) {
        products.map((product) {
          if (product.id == productId) {
            return ProductModel(
              id: product.id,
              productName: product.productName,
              description: product.description,
              pricePoints: product.pricePoints,
              discountPercentage: product.discountPercentage,
              finalPricePoints: product.finalPricePoints,
              imageUrl: product.imageUrl,
              categoryId: product.categoryId,
              inStock: (product.quantityAvailable + quantity) > 0,
              quantityAvailable: product.quantityAvailable + quantity,
              orderPriority: product.orderPriority,
            );
          }
          return product;
        }).toList();
      },
    );
  }
}
