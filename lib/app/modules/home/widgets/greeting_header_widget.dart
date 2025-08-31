import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/constant/uidata.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

import '../controllers/home_controller.dart';

class GreetingHeaderWidget extends StatelessWidget {
  const GreetingHeaderWidget({super.key});

  String getGreetingText() {
    final hour = DateTime.now().hour;
    if (hour < 10) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    '${getGreetingText()} ${controller.userName.value}!👋🏻',
                    style: AppTypography.h5SemiBold.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle notification tap
                  },
                  child: Image.network(notif, height: 25, width: 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
