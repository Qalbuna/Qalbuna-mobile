import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';

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
    final emailValid = emailController.text.isNotEmpty && 
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
        Get.offAllNamed(Routes.home);
      }
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

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // TODO: Implement Google sign in dengan Supabase
      // await Supabase.instance.client.auth.signInWithOAuth(Provider.google);
      
      Get.snackbar(
        'Info',
        'Google Sign In belum tersedia',
        backgroundColor: AppColors.v1Neutral400,
        colorText: AppColors.white,
      );
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

  void goToSignUp() {
    Get.toNamed(Routes.signUp);
  }
}