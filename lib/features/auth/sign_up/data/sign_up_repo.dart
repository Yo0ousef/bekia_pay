import 'dart:io';

import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/sign_up/data/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpRepo {
  Future<ApiResult<bool>> signUpWithEmailAndPassword({
    required UserModel user,
    required String password,
  }) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: user.email,
        password: password,
      );
      if (response.session != null && response.user != null) {
        Map<String, dynamic> userData = user.toJson(user);
        userData.addAll({'id': response.user!.id});
        await Supabase.instance.client.from("profiles").insert(userData);
        await Supabase.instance.client.auth.signOut();
        return const ApiResult.success(true);
      }
      return ApiResult.failure(LocaleKeys.session_creation_failed.tr());
    } on AuthException catch (error) {
      switch (error.statusCode) {
        case '400':
          if (error.message.contains('User already registered')) {
            return ApiResult.failure(LocaleKeys.email_already_used.tr());
          } else if (error.message.contains('Password should be at least')) {
            return ApiResult.failure(LocaleKeys.password_too_weak.tr());
          } else if (error.message.contains(
            'Password should contain at least',
          )) {
            return ApiResult.failure(LocaleKeys.password_too_weak.tr());
          }
          return ApiResult.failure(error.message);

        case '422':
          return ApiResult.failure(LocaleKeys.email_already_used.tr());

        case '429':
          return ApiResult.failure(LocaleKeys.too_many_login_attempts.tr());

        default:
          return ApiResult.failure(error.message);
      }
    } on SocketException {
      return ApiResult.failure(LocaleKeys.no_internet_connection.tr());
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
