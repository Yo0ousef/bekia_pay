import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/add_item_use_case.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/remove_item_use_case.dart';
import 'package:bekia_pay/features/cart/presentation/logic/cart_cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase _getCartItems;
  final AddItemUseCase _addItem;
  final RemoveItemUseCase _removeItem;
  final ClearCartUseCase _clearCart;
  late final Future<void> _initialLoad;

  CartCubit({
    required GetCartItemsUseCase getCartItems,
    required AddItemUseCase addItem,
    required RemoveItemUseCase removeItem,
    required ClearCartUseCase clearCart,
  }) : _getCartItems = getCartItems,
       _addItem = addItem,
       _removeItem = removeItem,
       _clearCart = clearCart,
       super(const CartState(isLoading: true)) {
    _initialLoad = loadCart();
  }

  Future<void> loadCart() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final items = await _getCartItems();
      if (!isClosed) {
        emit(state.copyWith(items: items, isLoading: false, clearError: true));
      }
    } catch (error) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
      }
    }
  }

  Future<void> addItem(CartItemEntity item) async {
    await _initialLoad;
    if (isClosed || state.isSaving) return;
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      final items = await _addItem(item);
      if (!isClosed) emit(state.copyWith(items: items, isSaving: false));
    } catch (error) {
      if (!isClosed) {
        emit(state.copyWith(isSaving: false, errorMessage: error.toString()));
      }
    }
  }

  Future<void> removeItem(CartItemEntity item) async {
    await _initialLoad;
    if (isClosed || state.isSaving) return;
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      final items = await _removeItem(item.productId);
      if (!isClosed) emit(state.copyWith(items: items, isSaving: false));
    } catch (error) {
      if (!isClosed) {
        emit(state.copyWith(isSaving: false, errorMessage: error.toString()));
      }
    }
  }

  Future<void> clearCart() async {
    await _initialLoad;
    if (isClosed || state.isSaving) return;
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _clearCart();
      if (!isClosed) {
        emit(
          state.copyWith(items: const [], isSaving: false, clearError: true),
        );
      }
    } catch (error) {
      if (!isClosed) {
        emit(state.copyWith(isSaving: false, errorMessage: error.toString()));
      }
    }
  }
}
