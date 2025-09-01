import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/home_controller.dart';

class QuranInsightCard extends GetView<HomeController> { 
  const QuranInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Gray200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.v1Primary25,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Icon(
                    Icons.lightbulb,
                    color: AppColors.v1Primary500,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Pesan Untukmu 💜',
                  style: AppTypography.mMedium.copyWith(
                    color: AppColors.v1Primary700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() {
              final moodData = controller.currentMoodData.value;
              
              if (moodData != null) {
                final entry = moodData['entry'] as Map<String, dynamic>;
                final moodType = entry['mood_types'] as Map<String, dynamic>;
                final moodValue = moodType['value'] as String;
                final selectedMood = controller.moodTypes.firstWhereOrNull(
                  (mood) => mood.value == moodValue,
                );
                if (selectedMood?.description != null) {
                  return Text(
                    '${selectedMood!.description!} ✨',
                    textAlign: TextAlign.justify,
                    style: AppTypography.sRegular.copyWith(
                      color: AppColors.black,
                      height: 1.4,
                    ),
                  );
                }
              }
              return Text(
                'Menghubungkan...',
                style: AppTypography.sRegular.copyWith(
                  color: AppColors.v1Neutral800,
                  height: 1.4,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}