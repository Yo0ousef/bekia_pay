import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientImpl implements DatabaseClient {
  final SupabaseClient _supabaseClient;

  SupabaseClientImpl(this._supabaseClient);

  @override
  Future<void> deleteData({required String table, required String id}) async {
    final deletedRows = await _supabaseClient
        .from(table)
        .delete()
        .eq('id', id)
        .select('id');
    if (deletedRows.isEmpty) {
      throw StateError('No $table row with id $id was deleted');
    }
  }

  @override
  Future<void> deleteDataWhere({
    required String table,
    required Map<String, dynamic> queryParams,
  }) async {
    if (queryParams.isEmpty) {
      throw ArgumentError('deleteDataWhere requires at least one filter');
    }

    dynamic query = _supabaseClient.from(table).delete();
    queryParams.forEach((column, value) {
      query = query.eq(column, value);
    });
    final deletedRows = await query.select();
    if (deletedRows.isEmpty) {
      throw StateError('No matching row in $table was deleted');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getData({
    required String table,
    String selectQuery = "*",
    Map<String, dynamic>? queryParams,
    String? orderBy,
    bool ascending = true,
  }) async {
    dynamic query = _supabaseClient.from(table).select(selectQuery);
    queryParams?.forEach((column, value) {
      query = query.eq(column, value);
    });
    if (orderBy != null) {
      query = query.order(orderBy, ascending: ascending);
    }
    final response = await query;
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
  Future<void> updateData({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final updatedRows = await _supabaseClient
        .from(table)
        .update(data)
        .eq('id', id)
        .select('id');
    if (updatedRows.isEmpty) {
      throw StateError('No $table row with id $id was updated');
    }
  }
}
