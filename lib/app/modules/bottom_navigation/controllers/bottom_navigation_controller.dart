// ignore_for_file: strict_top_level_inference

import 'package:get/get.dart';
import 'package:qalbuna_app/app/routes/app_pages.dart';

import '../../account/controllers/account_controller.dart';
import '../../challenge/controllers/challenge_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../journal/controllers/journal_controller.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;

  final screens = [
    Routes.home,
    Routes.journal,
    Routes.challenge,
    Routes.account,
  ];
  @override
  void onInit() {
    super.onInit();
    Get.put(HomeController());
    Get.put(JournalController());
    Get.put(ChallengeController());
    Get.put(AccountController());
  }

  void setIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
