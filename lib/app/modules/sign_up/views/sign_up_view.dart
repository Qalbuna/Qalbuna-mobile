import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';
import 'package:qalbuna_app/app/shared/widgets/custom_botton.dart';
import 'package:qalbuna_app/app/shared/widgets/custom_text_field.dart';
import 'package:qalbuna_app/app/shared/widgets/social_login_button.dart';
import 'package:qalbuna_app/app/shared/widgets/auth_redirect_text.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant/uidata.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Text(
                  'Hallo!👋🏻',
                  style: AppTypography.h2Bold.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 12),
                Text(
                  'Temukan fitur-fitur yang dapat membimbing hatimu lebih dekat kepada Al-Qur\'an, setiap hari.',
                  style: AppTypography.sRegular.copyWith(
                    color: AppColors.v1Neutral500,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  hintText: 'Username',
                  controller: controller.usernameController,
                  validator: controller.validateUsername,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Email',
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CustomTextField(
                    hintText: 'Password',
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    validator: controller.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.v1Neutral400,
                        size: 20,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 46),
                Obx(
                  () => controller.isLoading.value
                      ? Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.v1Primary400, 
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : CustomBotton(text: 'Daftar', onTap: controller.signUp),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.v1Neutral200,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Lainnya',
                        style: AppTypography.sRegular.copyWith(
                          color: AppColors.v1Neutral400,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.v1Neutral200,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Obx(
                  () => SocialLoginButton(
                    text: 'Daftar dengan Google',
                    icon: Image.network(google, height: 20, width: 20),
                    onTap: controller.isLoading.value
                        ? null
                        : controller.signUpWithGoogle,
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: AuthRedirectText(
                    questionText: 'Sudah punya akun?',
                    actionText: 'Sign In',
                    onActionTap: () {
                      Get.toNamed(Routes.signIn);
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
