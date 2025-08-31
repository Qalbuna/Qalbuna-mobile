import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import 'package:qalbuna_app/app/data/modules/mood_tracker_data.dart';
import '../controllers/home_controller.dart';

class MoodStatusWidget extends StatelessWidget {
  final MoodTrackerData? moodData;
  
  const MoodStatusWidget({
    super.key,
    this.moodData,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    
    if (moodData == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.v1Gray200),
        ),
        child: Column(
          children: [
            Text(
              'Belum ada data mood hari ini',
              style: AppTypography.h5Medium,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Navigate to mood tracker
              },
              child: const Text('Isi Mood Tracker'),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                controller.getMoodEmoji(moodData!.mood),
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hari ini, ${DateFormat('d MMMM', 'id_ID').format(DateTime.now())}',
                      style: AppTypography.sMedium.copyWith(
                        color: AppColors.v1Neutral400,
                      ),
                    ),
                    Text(
                      controller.getMoodLabel(moodData!.mood),
                      style: AppTypography.h5Bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (moodData!.needs.isNotEmpty) ...[
            Row(
              children: [
                Text(
                  controller.getNeedIcon(moodData!.needs.first),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  controller.getNeedLabel(moodData!.needs.first),
                  style: AppTypography.sMedium.copyWith(
                    color: AppColors.v1Neutral600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              const Text('📞', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(
                'Ingin lebih mendekat',
                style: AppTypography.sMedium.copyWith(
                  color: AppColors.v1Primary500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}