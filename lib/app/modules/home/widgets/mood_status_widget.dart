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
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final moodData = controller.currentMoodData.value;

      if (moodData == null) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.v1Primary500),
          ),
          child: Column(
            children: [
              Text(
                'Belum ada data mood hari ini', 
                style: AppTypography.h5Medium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: controller.navigateToMoodTracker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.v1Primary500,
                  foregroundColor: AppColors.white,
                ),
                child: const Text('Isi Mood Tracker'),
              ),
            ],
          ),
        );
      }

      // Extract data from Supabase response
      final entry = moodData['entry'] as Map<String, dynamic>;
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
            Row(
              children: [
                Text(
                  moodType['emoji'] ?? '😊',
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hari ini, ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.now())}',
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
            const SizedBox(height: 12),
            
            // Show needs and spiritual connection
            if (needs.isNotEmpty || connection != null) ...[
              Row(
                children: [
                  // Show first need if available
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
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.v1Neutral300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  
                  // Show spiritual connection if available
                  if (connection != null) ...[
                    Text(
                      connection['connection_types']['icon'] ?? '⭐',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        connection['connection_types']['label'] ?? 'Merasa dekat dan terhubung',
                        style: AppTypography.sMedium.copyWith(
                          color: AppColors.v1Primary500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
            ],

            // Show notes if available
            if (entry['notes'] != null && entry['notes'].toString().isNotEmpty) ...[
              Text(
                'Catatan: ${entry['notes']}',
                style: AppTypography.sRegular.copyWith(
                  color: AppColors.v1Neutral500,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Refresh button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: controller.refreshTodayMood,
                icon: Icon(
                  Icons.refresh,
                  size: 16,
                  color: AppColors.v1Primary500,
                ),
                label: Text(
                  'Refresh',
                  style: AppTypography.sRegular.copyWith(
                    color: AppColors.v1Primary500,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}