import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/mood_tracker_controller.dart';

class MoodSelectionWidget extends GetView<MoodTrackerController> {
  const MoodSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 6),
          Text('Bagaimana Perasaanmu hari ini?', style: AppTypography.h5Bold),
          const SizedBox(height: 12),
          Text(
            'Pilih yang paling mewakili hatimu sekarang 💜',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: controller.moodTypes.map((mood) {
                final isSelected =
                    controller.selectedMoodValue.value == mood.value;

                return GestureDetector(
                  onTap: () => controller.selectMood(mood.value),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.v1Primary50
                          : AppColors.v1Gray25,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.v1Primary500
                            : AppColors.v1Gray200,
                        width: isSelected ? 2 : 1,
                      ),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Gambar dengan batasan ukuran
                        Expanded(
                          flex: 2,
                          child: Image.network(
                            mood.emoji,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback jika gambar gagal load
                              return const Icon(
                                Icons.emoji_emotions,
                                size: 35,
                                color: Colors.grey,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.v1Primary500,
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          flex: 2,
                          child: Text(
                            mood.label,
                            style: AppTypography.sMedium.copyWith(
                              color: isSelected
                                  ? AppColors.v1Primary500
                                  : AppColors.black,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
