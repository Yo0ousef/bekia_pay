import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OptionsRepo {
  SupabaseClient get _supabase => Supabase.instance.client;

  User? get user => _supabase.auth.currentUser;

  Future<ApiResult<void>> signOut() async {
    try {
      await _supabase.auth.signOut().timeout(10.sec);

      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<ApiResult<Map<String, dynamic>>> getUserProfile() async {
    if (user == null) {
      throw ApiResult.failure('User not authenticated');
    }
    final data = await _supabase
        .from('profiles')
        .select()
        .eq('id', user!.id)
        .single();
    return ApiResult.success(data);
  }

  Future<ApiResult<void>> updateUserProfile({
    required String name,
    required String phone,
    required String governorate,
    required String city,
    required String street,
    required String houseNumber,
    required String floor,
    required String apartmentNumber,
  }) async {
    if (user == null) {
      throw ApiResult.failure('User not authenticated');
    }
    try {
      await _supabase
          .from('profiles')
          .update({
            'full_name': name,
            'phone': phone,
            'governorate': governorate,
            'city': city,
            'street': street,
            'house_number': houseNumber,
            'floor': floor,
            'apartment_number': apartmentNumber,
          })
          .eq('id', user!.id);
      return ApiResult.success(null);
    } catch (e) {
      throw ApiResult.failure('Failed to update profile: ${e.toString()}');
    }
  }

  Future<ApiResult<void>> updatePassword(String newPassword) async {
    if (user == null) {
      throw ApiResult.failure('User not authenticated');
    }
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      return ApiResult.success(null);
    } catch (e) {
      throw ApiResult.failure('Failed to update password: ${e.toString()}');
    }
  }
}
