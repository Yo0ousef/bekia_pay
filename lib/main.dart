import 'package:bekia_pay/app/bekia_pay.dart';
import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/core/shared/logic/cubits/theme_cubit.dart';
import 'package:bekia_pay/core/utils/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/dependency_injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting();
  await Prefs.init();
  DependencyInjection.setUp();
  await Supabase.initialize(
    url: 'https://ezoowkhdpyletwszvefg.supabase.co',
    publishableKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6b293a2hkcHlsZXR3c3p2ZWZnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIzNTIwMjYsImV4cCI6MjA3NzkyODAyNn0.hsC5ItmL9t8n-JfNJDjxekD0uvu4Kzk82ZUU5FreOlw",
  );
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      assetLoader: CodegenLoader(),
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: BlocProvider(
        create: (_) => DependencyInjection.getIt<ThemeCubit>(),
        child: BekiaPay(),
      ),
    ),
  );
}
