abstract class DatabaseClient {
  Future<List<Map<String, dynamic>>> getData({
    required String table,
    String selectQuery = '*',
    // Equality filters applied as PostgREST .eq(column, value) constraints.
    Map<String, dynamic>? queryParams,
    String? orderBy,
    bool ascending = true,
  });

  Future<Map<String, dynamic>> insertData({
    required String table,
    required Map<String, dynamic> data,
  });

  Future<void> updateData({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  });

  Future<void> deleteData({required String table, required String id});
}
