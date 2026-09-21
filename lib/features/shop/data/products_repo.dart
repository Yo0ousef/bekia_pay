import 'dart:developer';

import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/shop/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ApiResult<List<ProductModel>>> getProducts() async {
    try {
      final List<dynamic> response = await _supabase.from('products').select();

      final List<ProductModel> products = [];
      for (var item in response) {
        try {
          products.add(ProductModel.fromJson(item));
        } catch (exception) {
          log(exception.toString());
        }
      }
      return ApiResult.success(products);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
