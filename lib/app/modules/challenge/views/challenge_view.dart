import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/challenge_day_status.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/challenge_controller.dart';
import '../widgets/header/challange_progress_card.dart';
import '../widgets/challenge_day_list.dart';

class ChallengeView extends GetView<ChallengeController> {
  const ChallengeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tantangan 7 Hari',
                  style: AppTypography.h5SemiBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Dekat dengan Qur\'an 🕌⋆⁺₊✧',
                  style: AppTypography.sMedium.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.v1Primary500,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Obx(
              () => ChallengeProgressCard(
                currentDay: controller.currentDay.value,
                totalDays: controller.totalDays.value,
                completedDays: controller.completedDays.toList(),
                passedDays: controller.passedDays.toList(),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => ChallengeDayList(
                challengeDays: controller.challengeDays.toList(),
                onDayTap: (day) {
                  _handleDayTap(day, controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _handleDayTap(ChallengeDay day, ChallengeController controller) {
  switch (day.status) {
    case ChallengeDayStatus.active:
      controller.startChallenge(day);
      break;
    case ChallengeDayStatus.completed:
      break;
    case ChallengeDayStatus.locked:
      break;
    case ChallengeDayStatus.pass:
      break;
  }
}
