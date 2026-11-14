import 'package:bekia_pay/features/shop/domain/entities/product_entity.dart';
import 'package:bekia_pay/features/shop/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_cubit.freezed.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase _getProducts;

  ProductsCubit(this._getProducts) : super(const ProductsState.loading()) {
    getProducts();
  }

  Future<void> getProducts() async {
    if (state is! _Loading) emit(const ProductsState.loading());
    try {
      final products = await _getProducts();
      if (!isClosed) emit(ProductsState.success(products));
    } catch (error) {
      if (!isClosed) emit(ProductsState.failure(error.toString()));
    }
  }

  void updateLocalQuantity(String productId, int quantity) {
    state.maybeWhen(
      orElse: () => null,
      success: (products) {
        final updatedProducts = products.map((product) {
          if (product.id == productId) {
            final updatedQuantity = product.quantityAvailable + quantity;
            return product.copyWith(
              inStock: updatedQuantity > 0,
              quantityAvailable: updatedQuantity,
            );
          }
          return product;
        }).toList();
        emit(ProductsState.success(updatedProducts));
      },
    );
  }
}
