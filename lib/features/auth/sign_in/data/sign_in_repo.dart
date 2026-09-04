import 'dart:io';

import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInRepo {
  Future<ApiResult<bool>> sinInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null &&
          response.session!.accessToken.isNotEmpty) {
        return ApiResult.success(true);
      } else {
        return ApiResult.failure(LocaleKeys.session_creation_failed.tr());
      }
    } on AuthException catch (error) {
      switch (error.statusCode) {
        case '400':
          if (error.message.contains('Invalid login credentials')) {
            return ApiResult.failure(LocaleKeys.invaild_email_password.tr());
          } else if (error.message.contains('Email not confirmed')) {
            return ApiResult.failure(LocaleKeys.please_verify_email.tr());
          }
          return ApiResult.failure(error.message);

        case '422':
          return ApiResult.failure(LocaleKeys.invaild_email_format.tr());

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
