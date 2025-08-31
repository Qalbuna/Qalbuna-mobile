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
              'Bagaimana suasana hatimu hari ini? ❤️',
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
              const MoodSelectionWidget(),
              SizedBox(height: 16),
              const NeedSelectionWidget(),
              SizedBox(height: 16),
              const SpiritualConnectionWidget(),
              SizedBox(height: 24),
              Obx(() => CustomBotton(
                text: controller.isSubmitting.value 
                  ? 'Menyimpan...' 
                  : 'Temukan Pelukan Qur\'an Untukku',
                onTap: controller.isSubmitting.value 
                  ? null 
                  : controller.submitMoodTracker,
                isEnabled: controller.isFormCompletelyValid && !controller.isSubmitting.value,
              )),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
