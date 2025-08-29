import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  // Text controllers
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

  // Validate form
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email/Username tidak boleh kosong';
    }
    // Allow both email and username format
    if (value.contains('@') && !GetUtils.isEmail(value)) {
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

  // Sign in action
  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual sign in logic
      Get.snackbar(
        'Success',
        'Login berhasil!',
        backgroundColor: AppColors.v1Success500,
        colorText: AppColors.white,
      );

      // Navigate to home
      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal login: ${e.toString()}',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Google sign in
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Simulate Google sign in
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement Google sign in logic
      Get.snackbar(
        'Success',
        'Berhasil login dengan Google!',
        backgroundColor: AppColors.v1Success500,
        colorText: AppColors.white,
      );

      // Navigate to home
      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal login dengan Google: ${e.toString()}',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to forgot password
  void goToForgotPassword() {
    // TODO: Implement forgot password navigation
    Get.snackbar(
      'Info',
      'Fitur lupa password akan segera hadir!',
      backgroundColor: AppColors.v1Primary500,
      colorText: AppColors.white,
    );
  }

  // Navigate to sign up
  void goToSignUp() {
    Get.toNamed(Routes.signUp);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
