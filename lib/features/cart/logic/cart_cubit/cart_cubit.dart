import 'dart:convert';

import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:bekia_pay/features/shop/data/products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<List<CartItemModel>> {
  static const String _cartKey = 'cart_items';
  final ProductsRepo productsRepo;

  CartCubit(this.productsRepo) : super([]) {
    _loadCartFromCache();
  }

  void addItem(CartItemModel item) async {
    if (isClosed) return;

    final existingIndex = state.indexWhere(
      (element) => element.name == item.name,
    );

    List<CartItemModel> updatedList;
    if (existingIndex != -1) {
      updatedList = List<CartItemModel>.from(state);
      final existingItem = updatedList[existingIndex];

      updatedList[existingIndex] = CartItemModel(
        productId: existingItem.productId,
        name: existingItem.name,
        count: existingItem.count + item.count,
        imageUrl: existingItem.imageUrl,
        pricePoints: existingItem.pricePoints,
      );
    } else {
      updatedList = [...state, item];
    }
    emit(updatedList);

    _saveCartToCache(updatedList);

    if (isClosed) return;
  }

  void removeItem(CartItemModel item) {
    final updatedList = state
        .where((element) => element.productId != item.productId)
        .toList();
    emit(updatedList);
    _saveCartToCache(updatedList);
  }

  void clearCart() {
    emit([]);
    _saveCartToCache([]);
  }

  void _loadCartFromCache() {
    final String cartJson = Prefs.getString(_cartKey);
    if (cartJson.isNotEmpty) {
      try {
        final List<dynamic> decodedList = jsonDecode(cartJson);
        final List<CartItemModel> cachedItems = decodedList
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
        emit(cachedItems);
      } catch (e) {
        _saveCartToCache([]);
      }
    }
  }

  void _saveCartToCache(List<CartItemModel> items) {
    final List<Map<String, dynamic>> itemsJson = items.map((item) {
      return CartItemModel(
        productId: item.productId,
        name: item.name,
        count: item.count,
        imageUrl: item.imageUrl,
        pricePoints: item.pricePoints,
      ).toJson();
    }).toList();
    Prefs.setString(_cartKey, jsonEncode(itemsJson));
  }

  num get totalPoints {
    num total = 0;
    for (var item in state) {
      total += item.pricePoints * item.count;
    }
    return total;
  }

  int get totalItemsCount {
    return state.length;
  }
}
