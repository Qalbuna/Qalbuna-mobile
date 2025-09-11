import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth/auth_services.dart';

class SignInController extends GetxController {
  // Text controllers
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
        emailController.text.isNotEmpty &&
        GetUtils.isEmail(emailController.text);
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

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await authServices.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );

      if (response.session != null) {
        Get.snackbar(
          'Success',
          'Login berhasil!',
          backgroundColor: AppColors.v1Success500,
          colorText: AppColors.white,
        );
        emailController.clear();
        passwordController.clear();
        Get.offAllNamed(Routes.moodTracker);
      }
    } on AuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.message);
      Get.snackbar(
        'Login Gagal',
        'email atau password salah',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
        duration: Duration(seconds: 3),
      );
      throw Exception('Login failed: $errorMessage');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal login: kesalahan sistem',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
      throw Exception('Login failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final response = await authServices.signInWithGoogle();

      if (response.session != null) {
        Future.delayed(Duration(milliseconds: 500), () {
          Get.offAllNamed(Routes.moodTracker);
        });
      }
    } on AuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.message);
      Get.snackbar(
        'Login Google Gagal',
        'Email atau password salah',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
        duration: Duration(seconds: 3),
      );
      throw Exception('Login with Google failed: $errorMessage');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal login dengan Google',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
      throw Exception('Login with Google failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  String _getAuthErrorMessage(String error) {
    if (error.contains('Invalid login credentials')) {
      return 'Email atau password salah';
    } else if (error.contains('Email not confirmed')) {
      return 'Silakan konfirmasi email Anda terlebih dahulu';
    } else if (error.contains('Too many requests')) {
      return 'Terlalu banyak percobaan. Coba lagi nanti';
    }
    return error;
  }

  void goToSignUp() {
    Get.toNamed(Routes.signUp);
  }
}
