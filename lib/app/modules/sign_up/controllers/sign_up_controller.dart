import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';

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
  final isFormValid = false.obs;

  final authServices = AuthServices();

  @override
  void onInit() {
    super.onInit();

    usernameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void onClose() {
    // Remove listeners
    usernameController.removeListener(_validateForm);
    emailController.removeListener(_validateForm);
    passwordController.removeListener(_validateForm);

    // Dispose controllers
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _validateForm() {
    final usernameValid = usernameController.text.length >= 3;
    final emailValid =
        emailController.text.isNotEmpty &&
        GetUtils.isEmail(emailController.text);
    final passwordValid = passwordController.text.length >= 6;

    isFormValid.value = usernameValid && emailValid && passwordValid;
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
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

      final response = await authServices.signUpWithEmailPassword(
        usernameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
      );

      if (response.user != null) {
        Future.delayed(Duration(milliseconds: 500), () {
          Get.offAllNamed(Routes.home);
          Get.snackbar(
            'Success',
            'Akun berhasil dibuat.',
            backgroundColor: AppColors.v1Success500,
            colorText: AppColors.white,
            duration: Duration(seconds: 2),
          );
        });
      }
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

  Future<void> signUpWithGoogle() async {
    try {
      isLoading.value = true;

      // TODO: Implement Google sign up dengan Supabase
      // await _supabase.auth.signInWithOAuth(Provider.google);

      Get.snackbar(
        'Info',
        'Google Sign Up belum tersedia',
        backgroundColor: AppColors.v1Neutral400,
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
}
