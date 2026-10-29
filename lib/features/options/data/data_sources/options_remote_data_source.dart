import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OptionsRemoteDataSource {
  Future<Map<String, dynamic>> getUserProfile();

  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> profile,
  });

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> signOut();
}

class OptionsRemoteDataSourceImpl implements OptionsRemoteDataSource {
  static const _requestTimeout = Duration(seconds: 10);

  final DatabaseClient _databaseClient;
  final SupabaseClient _supabaseClient;

  OptionsRemoteDataSourceImpl({
    required this._databaseClient,
    required this._supabaseClient,
  });

  String get _userId {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) throw StateError('Not authenticated');
    return userId;
  }

  @override
  Future<Map<String, dynamic>> getUserProfile() async {
    final rows = await _databaseClient
        .getData(table: 'profiles', queryParams: {'id': _userId})
        .timeout(_requestTimeout);
    if (rows.length != 1) {
      throw StateError('The signed-in user profile was not found');
    }
    return rows.single;
  }

  @override
  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> profile,
  }) {
    if (userId != _userId) {
      throw StateError('Cannot update a different user profile');
    }
    return _databaseClient
        .updateData(table: 'profiles', id: userId, data: profile)
        .timeout(_requestTimeout);
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _supabaseClient.auth.currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      throw StateError('Not authenticated');
    }

    await _supabaseClient.auth
        .signInWithPassword(email: email, password: currentPassword)
        .timeout(_requestTimeout);
    await _supabaseClient.auth
        .updateUser(UserAttributes(password: newPassword))
        .timeout(_requestTimeout);
  }

  @override
  Future<void> signOut() =>
      _supabaseClient.auth.signOut().timeout(_requestTimeout);
}
