import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/mood_tracker_controller.dart';

class NeedSelectionWidget extends GetView<MoodTrackerController> {
  const NeedSelectionWidget({super.key});

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
          Text('Ceritakan lebih dalam', style: AppTypography.h5Bold),
          SizedBox(height: 12),
          Text(
            'Apa yang sedang kamu butuhkan hari ini?',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral500,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.needTypes.length,
              itemBuilder: (context, index) {
                final need = controller.needTypes[index];
                final isSelected = controller.selectedNeedValues.contains(
                  need.value,
                );

                return GestureDetector(
                  onTap: () => controller.toggleNeed(need.value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
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
                    child: Row(
                      children: [
                        Text(need.icon, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            need.label,
                            style: AppTypography.sMedium.copyWith(
                              color: isSelected
                                  ? AppColors.v1Primary500
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
