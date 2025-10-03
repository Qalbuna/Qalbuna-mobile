import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../controllers/home_controller.dart';

class DhikrAmalanWidget extends GetView<HomeController> {
  const DhikrAmalanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildContent(),
          const SizedBox(height: 16),
          _buildActionArea(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final category = controller.currentMoodData.value != null
          ? _getCategoryByEmotion(
              controller.currentMoodData.value!['entry']['mood_types']['value'],
            )
          : 'Amalan untuk Kehidupan';

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
    });
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Membaca Doa Ketenangan 3x', style: AppTypography.lSemiBold),
        const SizedBox(height: 16),
        Text(
          'بِسْمِ اللهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلاَ فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
          style: AppTypography.h5Bold.copyWith(height: 1.8),
          textAlign: TextAlign.right,
        ),
        Text(
          'Bismillāhillażī lā yaḍurru ma\'asmihi syai\'un fil-arḍi wa lā fis-samā\', wa huwas-samī\'ul \'alīm',
          style: AppTypography.sMedium.copyWith(
            color: AppColors.v1Neutral600,
            height: 1.3,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 12),
        Text(
          '"Dengan Nama Allah, Yang dengan Nama-Nya tidak ada sesuatu pun di bumi dan di langit yang dapat membahayakan, dan Dia-lah Yang Maha Mendengar lagi Maha Mengetahui."',
          style: AppTypography.sMedium.copyWith(
            color: AppColors.black,
            fontStyle: FontStyle.italic,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.v1Gray50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keutamaan:',
                style: AppTypography.sSemiBold.copyWith(
                  color: AppColors.v1Neutral700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Rasulullah SAW. bersabda, "Barangsiapa yang membacanya sebanyak tiga kali ketika pagi dan sore hari, maka tidak ada sesuatu pun yang dapat membahayakan dirinya."',
                style: AppTypography.sMedium.copyWith(
                  color: AppColors.v1Neutral600,
                  height: 1.3,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionArea() {
    return Obx(
      () => controller.isDhikrActive.value
          ? _buildCounter()
          : _buildStartButton(),
    );
  }

  Widget _buildStartButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: AppColors.v1Primary500,
        child: InkWell(
          onTap: controller.startDhikr,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'Mulai Dzikir',
                style: AppTypography.sMedium.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Column(
      children: [
        Row(
          children: [
            _buildCounterButton(
              Icons.remove,
              controller.decreaseDhikrCount,
              isDecrease: true,
            ),
            const SizedBox(width: 12),
            Expanded(child: _buildCounterDisplay()),
            const SizedBox(width: 12),
            _buildCounterButton(Icons.add, controller.increaseDhikrCount),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterButton(
    IconData icon,
    VoidCallback onPressed, {
    bool isDecrease = false,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: isDecrease
            ? Border.all(color: AppColors.v1Gray400)
            : Border.all(color: AppColors.v1Gray400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: isDecrease ? AppColors.black : AppColors.black,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildCounterDisplay() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.v1Gray400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Obx(
          () => Text(
            '${controller.dhikrCount.value}',
            style: AppTypography.lMedium.copyWith(color: AppColors.black),
          ),
        ),
      ),
    );
  }

  String _getCategoryByEmotion(String emotion) {
    const categories = {
      'sedih': 'Amalan untuk Mengatasi Kesedihan',
      'cemas': 'Amalan untuk Mengatasi Kecemasan',
      'bersalah': 'Amalan untuk Meminta Ampunan',
      'marah': 'Amalan untuk Mengatasi Kemarahan',
      'bahagia': 'Amalan untuk Bersyukur',
      'takut': 'Amalan untuk Meminta Perlindungan',
    };
    return categories[emotion] ?? 'Amalan untuk Kehidupan';
  }
}
