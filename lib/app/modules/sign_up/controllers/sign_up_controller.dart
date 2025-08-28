import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';

import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  // Text controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form state
  final formKey = GlobalKey<FormState>();
  final isRememberMe = false.obs;
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    isRememberMe.value = value ?? false;
  }

  // Validate form
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Username minimal 3 karakter';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  // Sign up action
  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual sign up logic
      Get.snackbar(
        'Success',
        'Akun berhasil dibuat!',
        backgroundColor: AppColors.v1Success500,
        colorText: AppColors.white,
      );
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal membuat akun: ${e.toString()}',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Google sign up
  Future<void> signUpWithGoogle() async {
    try {
      isLoading.value = true;

      // Simulate Google sign up
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement Google sign up logic
      Get.snackbar(
        'Success',
        'Berhasil daftar dengan Google!',
        backgroundColor: AppColors.v1Success500,
        colorText: AppColors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal daftar dengan Google: ${e.toString()}',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
