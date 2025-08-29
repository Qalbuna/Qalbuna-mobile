import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';
import 'package:qalbuna_app/app/shared/widgets/custom_botton.dart';
import 'package:qalbuna_app/app/shared/widgets/custom_text_field.dart';
import 'package:qalbuna_app/app/shared/widgets/social_login_button.dart';
import 'package:qalbuna_app/app/shared/widgets/auth_redirect_text.dart';
import '../../../shared/constant/uidata.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  Text(
                    'Selamat Datang',
                    style: AppTypography.h2Bold.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Temukan fitur-fitur yang dapat membimbing hatimu lebih dekat kepada Al-Qur\'an, setiap hari.',
                    style: AppTypography.sRegular.copyWith(
                      color: AppColors.v1Neutral500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    hintText: 'Email/Username',
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
                  const SizedBox(height: 32),
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
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : CustomBotton(text: 'Masuk', onTap: controller.signIn),
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
                      text: 'Login dengan Google',
                      icon: Image.network(google, height: 20, width: 20),
                      onTap: controller.isLoading.value
                          ? null
                          : controller.signInWithGoogle,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: AuthRedirectText(
                      questionText: 'Tidak punya akun?',
                      actionText: 'Register',
                      onActionTap: controller.goToSignUp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
