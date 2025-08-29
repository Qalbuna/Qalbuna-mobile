import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void onClose() {
    emailController.removeListener(_validateForm);
    passwordController.removeListener(_validateForm);
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _validateForm() {
    final emailValid =
        emailController.text.isNotEmpty && emailController.text.contains('@');
    final passwordValid = passwordController.text.length >= 6;

    isFormValid.value = emailValid && passwordValid;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!value.contains('@')) {
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

  void signIn() {
    if (isFormValid.value && !isLoading.value) {
      isLoading.value = true;
      // Implementasi login
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
        // Handle login result
      });
    }
  }

  void signInWithGoogle() {
    // Implementasi Google Sign In
  }

  void goToSignUp() {
    Get.toNamed(Routes.signUp);
  }
}
