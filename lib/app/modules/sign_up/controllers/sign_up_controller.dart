import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isRememberMe = false.obs;
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isFormValid = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    usernameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void onClose() {
    usernameController.removeListener(_validateForm);
    emailController.removeListener(_validateForm);
    passwordController.removeListener(_validateForm);
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _validateForm() {
    final usernameValid = usernameController.text.length >= 3;
    final emailValid = emailController.text.isNotEmpty && 
                      GetUtils.isEmail(emailController.text);
    final passwordValid = passwordController.text.length >= 6;
    
    isFormValid.value = usernameValid && emailValid && passwordValid;
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

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
    if (!isFormValid.value || isLoading.value) {
      return;
    }

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
      Get.offAllNamed(Routes.home);
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
      Get.offAllNamed(Routes.home);
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
}