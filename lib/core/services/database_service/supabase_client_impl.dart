import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientImpl implements DatabaseClient {
  final SupabaseClient _supabaseClient;

  SupabaseClientImpl(this._supabaseClient);

  @override
  Future<bool> deleteData({required String table, required String id}) async {
    try {
      await _supabaseClient.from(table).delete().eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getData({
    required String table,
    String selectQuery = "*",
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _supabaseClient.from(table).select(selectQuery);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<Map<String, dynamic>> insertData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    final response = await _supabaseClient
        .from(table)
        .insert(data)
        .select()
        .single();
    return response;
  }

  @override
  Future<bool> updateData({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _supabaseClient.from(table).update(data).eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
