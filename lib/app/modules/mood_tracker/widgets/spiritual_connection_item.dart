import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/mood_tracker_controller.dart';

class SpiritualConnectionWidget extends GetView<MoodTrackerController> {
  const SpiritualConnectionWidget({super.key});

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
          Text(
            'Bagaimana perasaanmu dengan\nAllah hari ini?',
            style: AppTypography.h5Bold,
            textAlign: TextAlign.center
          ),
          const SizedBox(height: 20),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: controller.connectionTypes.map((connection) {
                final isSelected = controller.selectedConnectionValue.value == connection.value;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => controller.selectConnection(connection.value),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.v1Primary50 : AppColors.v1Gray25,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.v1Primary500 : AppColors.v1Gray200,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            connection.icon,
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              connection.label,
                              style: AppTypography.sMedium.copyWith(
                                color: isSelected ? AppColors.v1Primary500 : AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}