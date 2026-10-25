abstract class DatabaseClient {
  Future<List<Map<String, dynamic>>> getData({
    required String table,
    String selectQuery,
    Map<String, dynamic>? queryParams,
  });

  Future<Map<String, dynamic>> insertData({
    required String table,
    required Map<String, dynamic> data,
  });

  Future<bool> updateData({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  });

  Future<bool> deleteData({required String table, required String id});
}
