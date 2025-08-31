import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/home_controller.dart';

class MoodStatusWidget extends GetView<HomeController> {
  const MoodStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.v1Primary500),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final moodData = controller.currentMoodData.value;
      final entry = moodData!['entry'] as Map<String, dynamic>;
      final moodType = entry['mood_types'] as Map<String, dynamic>;
      final needs = moodData['needs'] as List<dynamic>;
      final connection = moodData['connection'] as Map<String, dynamic>?;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.v1Primary500),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  moodType['emoji'] ?? '😊',
                  style: const TextStyle(fontSize: 42),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perasaanmu hari ini, ${DateFormat('d MMMM', 'id_ID').format(DateTime.now())}',
                        style: AppTypography.sMedium.copyWith(
                          color: AppColors.v1Neutral500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        moodType['label'] ?? 'Baik',
                        style: AppTypography.h5SemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (needs.isNotEmpty || connection != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (needs.isNotEmpty) ...[
                    Text(
                      needs.first['need_types']['icon'] ?? '🤲',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      needs.first['need_types']['label'] ?? 'Ketenangan',
                      style: AppTypography.sRegular.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                  if (needs.isNotEmpty && connection != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.v1Neutral200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (connection != null) ...[
                    Text(
                      connection['connection_types']['icon'] ?? '⭐',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        connection['connection_types']['label'] ??
                            'Merasa dekat dan terhubung',
                        style: AppTypography.sRegular.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => controller.navigateToMoodTracker(),
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: AppColors.v1Primary400,
                      ),
                      label: Text(
                        'Perbarui Perasaan',
                        style: AppTypography.sMedium.copyWith(
                          color: AppColors.v1Primary400,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        backgroundColor: AppColors.v1Purple25,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      );
    });
  }
}
