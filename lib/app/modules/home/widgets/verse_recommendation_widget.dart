import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/home_controller.dart';

class VerseRecommendationWidget extends GetView<HomeController> {
  const VerseRecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Loading state
      if (controller.isLoading.value || controller.isVerseLoading.value) {
        return _buildLoadingState();
      }

      // No verse state
      if (controller.currentVerse.value == null) {
        return _buildEmptyState();
      }

      // Show verse
      return _buildVerseCard();
    });
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text(
            'Memuat ayat untukmu...',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Primary500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Icon(Icons.book_outlined, size: 48, color: AppColors.v1Primary300),
          const SizedBox(height: 16),
          Text(
            'Bagikan perasaanmu untuk mendapat ayat yang sesuai',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Primary500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.navigateToMoodTracker,
            child: const Text('Bagikan Perasaan'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerseCard() {
    final verse = controller.currentVerse.value!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          // Header
          _buildHeader(),
          const SizedBox(height: 16),

          // Arabic text
          Text(
            verse.arabicText,
            style: AppTypography.h5Bold.copyWith(height: 1.8, fontSize: 18),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),

          // Translation
          Text(
            '"${verse.translationId}"',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral600,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Reference
          Text(
            verse.reference,
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Primary500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    // Get emotion from current mood
    String category = 'Ayat untuk Kehidupan';
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
        // Audio button
        Expanded(child: _buildAudioButton()),
        const SizedBox(width: 12),

        // Get another verse button
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
      // Audio loading
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

      // Audio not available
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

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.v1Primary25,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.v1Primary100),
      boxShadow: [
        BoxShadow(
          color: AppColors.v1Primary50,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  String _getCategoryByEmotion(String emotion) {
    final categories = {
      'sedih': 'Ayat untuk Penghiburan',
      'cemas': 'Ayat untuk Ketenangan',
      'bersalah': 'Ayat untuk Ampunan',
      'marah': 'Ayat untuk Kesabaran',
      'bahagia': 'Ayat untuk Syukur',
      'takut': 'Ayat untuk Perlindungan',
    };

    return categories[emotion] ?? 'Ayat untuk Kehidupan';
  }
}
