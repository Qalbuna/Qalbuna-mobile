import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/home_controller.dart';

class SimpleAudioPlayerButton extends GetView<HomeController> {
  const SimpleAudioPlayerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.currentVerseAudioUrl.value == null) {
        return const SizedBox.shrink();
      }

      final isPlaying = controller.audioService.isPlaying.value &&
          controller.audioService.currentUrl.value == controller.currentVerseAudioUrl.value;
      
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.v1Primary50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.v1Primary200),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: controller.togglePlayPause,
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                color: AppColors.v1Primary500,
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPlaying ? 'Sedang memutar murotal' : 'Dengarkan murotal ayat',
                    style: AppTypography.sMedium.copyWith(
                      color: AppColors.v1Primary700,
                    ),
                  ),
                  if (isPlaying)
                    Text(
                      'Tap untuk pause',
                      style: AppTypography.sRegular.copyWith(
                        color: AppColors.v1Primary500,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            
            if (isPlaying)
              IconButton(
                onPressed: controller.stopAudio,
                icon: Icon(
                  Icons.stop,
                  color: AppColors.v1Primary500,
                ),
              ),
          ],
        ),
      );
    });
  }
}