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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            PageView(
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
            Positioned(
              bottom: 70.0,
              left: 0,
              right: 0,
              child: Obx(
                () => Column(
                  children: [
                    controller.page.value != 2
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
                              Get.offAllNamed(Routes.HOME);
                            },
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
                        Text(
                          'Sign In',
                          style: AppTypography.sBold.copyWith(
                            color: AppColors.v1Primary500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
