import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/theme/index.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtwZXpuZWpkbWplZ29idnNzb2FhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY0NzIyMzMsImV4cCI6MjA3MjA0ODIzM30.g_WIqRsmmxJpkEtQZ0FWhYJ9GUbpP-cdVjvFXeyQ2nQ',
    url: 'https://kpeznejdmjegobvssoaa.supabase.co',
  );
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(
    GetMaterialApp(
      title: "Qalbuna",
      initialRoute: AppPages.initila,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    ),
  );
}
