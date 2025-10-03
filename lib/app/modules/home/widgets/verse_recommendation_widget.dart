import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../../../shared/widgets/shimmer_placeholder.dart';
import '../controllers/home_controller.dart';
import 'card_decoration.dart';
import 'kandungan.dart';

class VerseRecommendationWidget extends GetView<HomeController> {
  const VerseRecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.currentVerse.value == null) {
        return _buildEmptyState();
      }
      return _buildVerseCard();
    });
  }

  Widget _buildEmptyState() {
    return Column(children: [Center(child: ShimmerPlaceholder())]);
  }

  Widget _buildVerseCard() {
    final verse = controller.currentVerse.value!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: CardDecoration.primary(),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          Text(
            verse.arabicText,
            style: AppTypography.h5Bold.copyWith(height: 1.8, fontSize: 18),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),
          Text(
            '"${verse.translationId}"',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral600,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            verse.reference,
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Primary500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Get.to(() => const Kandungan());
            },
            child: Row(
              children: [
                Text(
                  'Baca Kandungan Ayat',
                  style: AppTypography.sMedium.copyWith(
                    color: AppColors.v1Primary500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.v1Primary500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.v1Primary500,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String category = '';
    if (controller.currentMoodData.value != null) {
      final entry =
          controller.currentMoodData.value!['entry'] as Map<String, dynamic>;
      final moodType = entry['mood_types'] as Map<String, dynamic>;
      category = _getCategoryByEmotion(moodType['value']);
    }

    return Row(
      children: [
        Icon(Icons.auto_awesome, color: AppColors.v1Primary500, size: 18),
        const SizedBox(width: 8),
        Text(
          category,
          style: AppTypography.sSemiBold.copyWith(
            color: AppColors.v1Primary500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(child: _buildAudioButton()),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: controller.getAnotherVerse,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.v1Primary500,
              side: BorderSide(color: AppColors.v1Primary500),
            ),
            child: const Text('Ayat Lain'),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioButton() {
    return Obx(() {
      if (controller.isAudioLoading.value) {
        return ElevatedButton.icon(
          onPressed: null,
          icon: const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          label: const Text('Loading...'),
        );
      }
      if (controller.currentVerseAudioUrl.value != null) {
        final isPlaying =
            controller.audioService.isPlaying.value &&
            controller.audioService.currentUrl.value ==
                controller.currentVerseAudioUrl.value;

        return ElevatedButton.icon(
          onPressed: controller.togglePlayPause,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.v1Primary500,
            foregroundColor: Colors.white,
          ),
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 18),
          label: Text(isPlaying ? 'Pause' : 'Dengar'),
        );
      }
      return ElevatedButton.icon(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.v1Neutral300,
        ),
        icon: const Icon(Icons.volume_off, size: 18),
        label: const Text('Audio N/A'),
      );
    });
  }

  String _getCategoryByEmotion(String emotion) {
    final categories = {
      'sedih': 'Ayat Penghiburan',
      'cemas': 'Ayat Ketenangan',
      'bersalah': 'Ayat Ampunan',
      'marah': 'Ayat Kesabaran',
      'bahagia': 'Ayat Syukur',
      'takut': 'Ayat Perlindungan',
    };

    return categories[emotion] ?? 'Ayat untuk Kehidupan';
  }
}
