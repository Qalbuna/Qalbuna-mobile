import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/constant/uidata.dart';
import '../../../shared/theme/app_colors.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Image.network(splashScreen),
          ),
        ),
      ),
    );
  }
}
