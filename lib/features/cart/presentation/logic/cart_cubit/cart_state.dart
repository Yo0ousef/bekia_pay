import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';

class CartState {
  final List<CartItemEntity> items;
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;

  const CartState({
    this.items = const [],
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
  });

  num get totalPoints => items.fold<num>(
    0,
    (total, item) => total + item.pricePoints * item.quantity,
  );

  int get uniqueProductCount => items.length;

  CartState copyWith({
    List<CartItemEntity>? items,
    bool? isLoading,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
  }) => CartState(
    items: items ?? this.items,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
