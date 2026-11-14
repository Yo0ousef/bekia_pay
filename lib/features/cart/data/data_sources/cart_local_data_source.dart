import 'dart:convert';

import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/features/cart/data/models/cart_item_model.dart';

abstract interface class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();

  Future<void> saveCartItems(List<CartItemModel> items);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const _cartKey = 'cart_items';

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final encodedItems = Prefs.getString(_cartKey);
    if (encodedItems.isEmpty) return const [];

    final decoded = jsonDecode(encodedItems);
    if (decoded is! List) {
      throw const FormatException('Stored cart must be a JSON array');
    }

    return decoded.map((item) {
      if (item is! Map) {
        throw const FormatException('Stored cart items must be JSON objects');
      }
      return CartItemModel.fromJson(Map<String, dynamic>.from(item));
    }).toList(growable: false);
  }

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    final encodedItems = jsonEncode(items.map((item) => item.toJson()).toList());
    final saved = await Prefs.setString(_cartKey, encodedItems);
    if (!saved) throw StateError('Could not save the cart locally');
  }
}
