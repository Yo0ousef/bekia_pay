part of 'products_cubit.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.loading() = _Loading;

  const factory ProductsState.failure(String message) = _Failure;

  const factory ProductsState.success(List<ProductModel> products) = _Success;
}
