import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/mood_tracker_controller.dart';

class NeedSelectionWidget extends GetView<MoodTrackerController> {
  const NeedSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedMoodValue.value.isEmpty) {
        return const SizedBox.shrink();
      }

      final needTypes = controller.filteredNeedTypes;

      final selectedNeed = controller.selectedNeedValue.value;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
            const SizedBox(height: 12),
            Text(
              'Pilih yang paling menggambarkan perasaanmu saat ini',
              style: AppTypography.sMedium.copyWith(
                color: AppColors.v1Neutral500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: needTypes.length,
              itemBuilder: (context, index) {
                final need = needTypes[index];
                final isSelected = selectedNeed == need.value;

                return InkWell(
                  onTap: () => controller.selectNeed(need.value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    });
  }
}
