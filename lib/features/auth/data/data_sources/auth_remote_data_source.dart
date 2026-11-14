import 'dart:io';

import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/data/models/auth_user_model.dart';
import 'package:bekia_pay/features/auth/domain/errors/auth_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required AuthUserModel user,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  const AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session == null || response.session!.accessToken.isEmpty) {
        throw AuthFailure(LocaleKeys.session_creation_failed.tr());
      }
    } on AuthFailure {
      rethrow;
    } on AuthException catch (error) {
      throw AuthFailure(_authErrorMessage(error));
    } on SocketException {
      throw AuthFailure(LocaleKeys.no_internet_connection.tr());
    } catch (error) {
      throw AuthFailure(error.toString());
    }
  }

  @override
  Future<void> signUp({
    required AuthUserModel user,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: user.email,
        password: password,
      );
      final authUser = response.user;
      if (response.session == null || authUser == null) {
        throw AuthFailure(LocaleKeys.session_creation_failed.tr());
      }

      await supabaseClient.from('profiles').insert(user.toJson(id: authUser.id));
      await supabaseClient.auth.signOut();
    } on AuthFailure {
      rethrow;
    } on AuthException catch (error) {
      throw AuthFailure(_authErrorMessage(error, isSignUp: true));
    } on SocketException {
      throw AuthFailure(LocaleKeys.no_internet_connection.tr());
    } catch (error) {
      throw AuthFailure(error.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } on AuthException catch (error) {
      throw AuthFailure(_authErrorMessage(error));
    } on SocketException {
      throw AuthFailure(LocaleKeys.no_internet_connection.tr());
    } catch (error) {
      throw AuthFailure(error.toString());
    }
  }

  String _authErrorMessage(AuthException error, {bool isSignUp = false}) {
    switch (error.statusCode) {
      case '400':
        if (error.message.contains('Invalid login credentials')) {
          return LocaleKeys.invaild_email_password.tr();
        }
        if (error.message.contains('Email not confirmed')) {
          return LocaleKeys.please_verify_email.tr();
        }
        if (error.message.contains('User already registered')) {
          return LocaleKeys.email_already_used.tr();
        }
        if (error.message.contains('Password should')) {
          return LocaleKeys.password_too_weak.tr();
        }
        return error.message;
      case '422':
        return isSignUp
            ? LocaleKeys.email_already_used.tr()
            : LocaleKeys.invaild_email_format.tr();
      case '429':
        return LocaleKeys.too_many_login_attempts.tr();
      default:
        return error.message;
    }
  }
}
