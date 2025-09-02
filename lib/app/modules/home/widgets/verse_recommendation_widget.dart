// lib/app/modules/home/widgets/verse_recommendation_widget.dart
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
        return _buildLoadingContainer();
      }

      // No mood data state
      if (controller.currentMoodData.value == null || 
          controller.currentVerse.value == null) {
        return _buildNoMoodContainer();
      }

      final verse = controller.currentVerse.value!;
      final moodData = controller.currentMoodData.value!;
      final entry = moodData['entry'] as Map<String, dynamic>;
      final moodType = entry['mood_types'] as Map<String, dynamic>;

      return _buildVerseContainer(verse, moodType);
    });
  }

  Widget _buildLoadingContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.v1Primary25,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Primary100),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
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

  Widget _buildNoMoodContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.v1Primary25,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Primary100),
      ),
      child: Column(
        children: [
          Icon(
            Icons.book_outlined,
            size: 48,
            color: AppColors.v1Primary300,
          ),
          const SizedBox(height: 16),
          Text(
            'Bagikan suasana hatimu terlebih dahulu untuk mendapatkan ayat yang sesuai',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Primary500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.navigateToMoodTracker,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.v1Primary500,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Bagikan Perasaan', style: AppTypography.sMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildVerseContainer(dynamic verse, Map<String, dynamic> moodType) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.v1Primary25,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Primary100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header dengan kategori ayat
          _buildHeader(moodType['value']),
          const SizedBox(height: 16),

          // Teks Arab
          _buildArabicText(verse.arabicText),
          const SizedBox(height: 12),

          // Terjemahan
          _buildTranslation(verse.translationId),
          const SizedBox(height: 8),

          // Referensi ayat
          _buildReference(verse),

          // Tafsir singkat jika ada
          if (verse.interpretation?.briefInterpretation != null)
            _buildBriefTafsir(verse.interpretation!.briefInterpretation!),
          
          const SizedBox(height: 16),

          // Tombol aksi utama
          _buildMainActionButtons(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildHeader(String emotionValue) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        _getVerseCategory(emotionValue),
        style: AppTypography.sSemiBold.copyWith(
          color: AppColors.v1Primary500,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildArabicText(String arabicText) {
    return Text(
      arabicText,
      style: AppTypography.h5Bold.copyWith(
        color: AppColors.black,
        height: 1.8,
        fontSize: 18,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildTranslation(String translation) {
    return Text(
      '"$translation"',
      style: AppTypography.sMedium.copyWith(
        color: AppColors.v1Neutral600,
        fontStyle: FontStyle.italic,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildReference(dynamic verse) {
    return Text(
      verse.reference,
      style: AppTypography.sMedium.copyWith(
        color: AppColors.v1Primary500,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBriefTafsir(String briefTafsir) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.v1Primary50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.v1Primary200),
          ),
          child: Text(
            briefTafsir,
            style: AppTypography.sRegular.copyWith(
              color: AppColors.v1Primary700,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildMainActionButtons() {
    return Row(
      children: [
        // Tombol Audio
        Expanded(
          child: Obx(() => ElevatedButton.icon(
            onPressed: _getAudioButtonAction(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _getAudioButtonColor(),
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: _getAudioButtonIcon(),
            label: Text(_getAudioButtonText(), style: AppTypography.sMedium),
          )),
        ),
        const SizedBox(width: 12),

        // Tombol Tafsir
        OutlinedButton(
          onPressed: controller.currentVerse.value?.interpretation != null
              ? controller.navigateToVerseDetail
              : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.v1Primary500,
            side: BorderSide(color: AppColors.v1Primary500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledForegroundColor: AppColors.v1Neutral400,
          ),
          child: Text('Tafsir', style: AppTypography.sMedium),
        ),
      ],
    );
  }

 
  // Helper methods untuk audio button
  VoidCallback? _getAudioButtonAction() {
    if (controller.isAudioLoading.value) return null;
    
    if (controller.currentVerseAudioUrl.value != null) {
      return controller.playVerseAudio;
    }
    
    return null;
  }

  Color _getAudioButtonColor() {
    if (controller.currentVerseAudioUrl.value != null) {
      return AppColors.v1Primary500;
    }
    return AppColors.v1Neutral300;
  }

  Widget _getAudioButtonIcon() {
    if (controller.isAudioLoading.value) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    
    return const Icon(Icons.play_arrow, size: 18);
  }

  String _getAudioButtonText() {
    if (controller.isAudioLoading.value) {
      return 'Loading...';
    }
    
    if (controller.currentVerseAudioUrl.value != null) {
      return 'Dengar Audio';
    }
    
    return 'Audio N/A';
  }

  String _getVerseCategory(String emotionValue) {
    switch (emotionValue) {
      case 'sedih':
        return 'Ayat untuk Penghiburan';
      case 'cemas':
        return 'Ayat untuk Ketenangan';
      case 'bersalah':
        return 'Ayat untuk Ampunan';
      case 'marah':
        return 'Ayat untuk Kesabaran';
      case 'bahagia':
        return 'Ayat untuk Syukur';
      case 'takut':
        return 'Ayat untuk Perlindungan';
      default:
        return 'Ayat untuk Kehidupan';
    }
  }
}