import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/constant/uidata.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../../account/controllers/account_controller.dart';
import '../../account/views/account_view.dart';
import '../../challenge/controllers/challenge_controller.dart';
import '../../challenge/views/challenge_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';
import '../../journal/controllers/journal_controller.dart';
import '../../journal/views/journal_view.dart';
import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          switch (controller.currentIndex.value) {
            case 0:
              if (!Get.isRegistered<HomeController>()) {
                Get.lazyPut(() => HomeController());
              }
              return const HomeView();
            case 1:
              if (!Get.isRegistered<ChallengeController>()) {
                Get.lazyPut(() => ChallengeController());
              }
              return const ChallengeView();
            case 2:
              if (!Get.isRegistered<JournalController>()) {
                Get.lazyPut(() => JournalController());
              }
              return const JournalView();
            case 3:
              if (!Get.isRegistered<AccountController>()) {
                Get.lazyPut(() => AccountController());
              }
              return const AccountView();
            default:
              if (!Get.isRegistered<HomeController>()) {
                Get.lazyPut(() => HomeController());
              }
              return const HomeView();
          }
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            selectedLabelStyle: AppTypography.sMedium,
            unselectedLabelStyle: AppTypography.sRegular,
            unselectedItemColor: AppColors.v1Gray500,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => controller.setIndex(index),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          controller.currentIndex.value == 0 ? home : unhome,
                        ),
                      ),
                    ),
                  ),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          controller.currentIndex.value == 1
                              ? challenge
                              : unchallenge,
                        ),
                      ),
                    ),
                  ),
                ),
                label: 'Tantangan',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          controller.currentIndex.value == 2 ? journal : unjournal,
                        ),
                      ),
                    ),
                  ),
                ),
                label: 'Jurnal',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          controller.currentIndex.value == 3 ? account : unaccount,
                        ),
                      ),
                    ),
                  ),
                ),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
