import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.HOME);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  final count = 0.obs;
  void increment() => count.value++;
}
