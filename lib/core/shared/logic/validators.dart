import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';

class Validators {
  Validators._();

  static String? emptyValidate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.required.tr();
    }
    return null;
  }

  static String? emailValidate(String? value) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
    );
    const Set<String> allowedDomains = {
      'gmail.com',
      'yahoo.com',
      'hotmail.com',
      'outlook.com',
      'live.com',
      'icloud.com',
      'me.com',
      'mac.com',
      'proton.me',
      'protonmail.com',
      'aol.com',
      'zoho.com',
      'yandex.com',
      'gmx.com',
      'mail.com',
    };
    final trimmedValue = value?.trim().toLowerCase();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return LocaleKeys.required.tr();
    }
    if (!emailRegex.hasMatch(trimmedValue)) {
      return LocaleKeys.please_enter_valid_email.tr();
    }
    final domain = trimmedValue.split('@').last;
    if (!allowedDomains.contains(domain)) {
      return LocaleKeys.unsupported_email_domain.tr();
    }
    return null;
  }

  static String? numbersValidate(String? value) {
    final RegExp numberRegex = RegExp(r'^[0-9]+$');
    if (value == null || value.isEmpty) {
      return LocaleKeys.required.tr();
    }
    if (!numberRegex.hasMatch(value)) {
      return LocaleKeys.please_enter_valid_number.tr();
    }
    return null;
  }

  static String? passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.required.tr();
    }
    if (value.length < 8) {
      return LocaleKeys.password_must_be_at_least_8_characters.tr();
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return LocaleKeys.must_contain_uppercase.tr();
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return LocaleKeys.must_contain_lowercase.tr();
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return LocaleKeys.must_contain_number.tr();
    }
    return null;
  }
}
