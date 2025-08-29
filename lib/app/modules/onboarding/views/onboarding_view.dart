import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/modules/onboarding/widgets/list_onboarding.dart';
import 'package:qalbuna_app/app/shared/constant/uidata.dart';
import 'package:qalbuna_app/app/shared/widgets/custom_botton.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.indicator,
                  onPageChanged: (value) {
                    controller.page.value = value;
                  },
                  children: [
                    ListOnboarding(
                      image: onboard1,
                      title: 'Temukan ketenangan hati',
                      description: 'Mulai perjalananmu dengan Qalbuna',
                    ),
                    ListOnboarding(
                      image: onboard2,
                      title: 'Awali harimu dengan makna',
                      description: 'Kenali hatimu, resapi ayat-Nya',
                    ),
                    ListOnboarding(
                      image: onboard3,
                      title: 'Tulis.Renungi.Tumbuh.',
                      description:
                          'Mulai journaling dan dekatkan diri pada Al-Qur\'an',
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: controller.page.value == index
                                ? AppColors.v1Primary500
                                : AppColors.v1Neutral25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => controller.page.value != 2
                        ? CustomBotton(
                            text: 'Selanjutnya',
                            onTap: () {
                              controller.indicator.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          )
                        : CustomBotton(
                            text: 'Daftar sekarang',
                            onTap: () {
                              Get.offAllNamed(Routes.signUp);
                            },
                          ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: AppTypography.sRegular.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.signIn);
                        },
                        child: Text(
                          'Sign In',
                          style: AppTypography.sBold.copyWith(
                            color: AppColors.v1Primary500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
