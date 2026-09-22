import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/materials/data/models/material_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaterialsRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ApiResult<List<MaterialModel>>> fetchMaterials() async {
    try {
      final List<dynamic> response = await _supabase.from('materials').select();
      final List<MaterialModel> materials = [];
      for (var item in response) {
        try {
          materials.add(MaterialModel.fromJson(item));
        } catch (exception) {
          return ApiResult.failure(exception.toString());
        }
      }
      return ApiResult.success(materials);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
