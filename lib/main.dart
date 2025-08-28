import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/theme/index.dart';

void main() {
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
