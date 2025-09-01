import 'package:get/get.dart';

import '../controllers/challenge_controller.dart';

class ChallengeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengeController>(
      () => ChallengeController(),
    );
  }
}
