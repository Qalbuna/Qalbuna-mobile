import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/widgets/custom_botton.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/mood_tracker_controller.dart';
import '../widgets/mood_selection_widgets.dart';
import '../widgets/need_selection_widget.dart';
import '../widgets/spiritual_connection_item.dart';

class MoodTrackerView extends GetView<MoodTrackerController> {
  const MoodTrackerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mood Tracker',
              style: AppTypography.h5SemiBold.copyWith(color: AppColors.white),
            ),
            SizedBox(height: 6),
            Text(
              'Bagaimana hatimu hari ini? ❤️',
              style: AppTypography.sMedium.copyWith(color: AppColors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.v1Primary500,
        toolbarHeight: 80,
      ),
      backgroundColor: AppColors.v1CoolGray50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              Obx(
                () => MoodSelectionWidget(
                  selectedMood: controller.selectedMood.value,
                  onMoodSelected: controller.selectMood,
                ),
              ),
              SizedBox(height: 16),
              Obx(
                () => NeedSelectionWidget(
                  selectedNeeds: controller.selectedNeeds.toList(),
                  onNeedToggled: controller.toggleNeed,
                ),
              ),
              SizedBox(height: 16),
              Obx(
                () => SpiritualConnectionWidget(
                  selectedConnection: controller.selectedConnection.value,
                  onConnectionSelected: controller.selectConnection,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => CustomBotton(
                  text: 'Temukan Pelukan Qur\'an Untukku',
                  onTap: controller.submitMoodTracker,
                  isEnabled: controller.isFormCompletelyValid,
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
