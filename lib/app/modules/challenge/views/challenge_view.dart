import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/challenge_controller.dart';
import '../widgets/challange_progress_card.dart';

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
            ChallengeProgressCard(
              currentDay: 3,
              totalDays: 7,
              completedDays: [1, 3], // Heart akan menampilkan "1" dan "2"
              passedDays: [2], // Heart pass/gagal tanpa angka
            ),
          ],
        ),
      ),
    );
  }
}
