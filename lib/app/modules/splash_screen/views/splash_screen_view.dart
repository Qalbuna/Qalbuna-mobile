import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/constant/uidata.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/app_colors.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.ONBOARDING);
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: Get.width * 0.8,
            height: Get.width * 0.8,
            child: Image.network(splashScreen),
          ),
        ),
      ),
    );
  }
}
