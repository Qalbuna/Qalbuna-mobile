import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';

class SignUpController extends GetxController {
  // Text controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form state
  final formKey = GlobalKey<FormState>();
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
        usernameController.clear();
        emailController.clear();
        passwordController.clear();

        Get.snackbar(
          'Success',
          'Selamat datang, ${response.user!.userMetadata!['username']}!',
          backgroundColor: AppColors.v1Success500,
          colorText: AppColors.white,
          duration: Duration(seconds: 3),
        );

        Future.delayed(Duration(milliseconds: 500), () {
          Get.offAllNamed(Routes.home);
        });
      }
    } on AuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.message);
      Get.snackbar(
        'Registrasi Gagal',
        errorMessage,
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
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

      final response = await authServices.signUpWithGoogle();

      if (response.session != null) {
        Get.snackbar(
          'Success',
          'Registrasi dengan Google berhasil!',
          backgroundColor: AppColors.v1Success500,
          colorText: AppColors.white,
          duration: Duration(seconds: 2),
        );

        // Navigate to home after successful Google sign up
        Future.delayed(Duration(milliseconds: 500), () {
          Get.offAllNamed(Routes.home);
        });
      }
    } on AuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.message);
      Get.snackbar(
        'Registrasi Google Gagal',
        errorMessage,
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
        duration: Duration(seconds: 3),
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

  String _getAuthErrorMessage(String error) {
    if (error.contains('User already registered')) {
      return 'Email sudah terdaftar. Silakan gunakan email lain atau login';
    } else if (error.contains('Password should be at least')) {
      return 'Password terlalu lemah. Gunakan kombinasi huruf, angka, dan simbol';
    } else if (error.contains('Invalid email')) {
      return 'Format email tidak valid';
    } else if (error.contains('Too many requests')) {
      return 'Terlalu banyak percobaan. Coba lagi nanti';
    }
    return error;
  }

  void goToSignIn() {
    Get.back();
  }
}
