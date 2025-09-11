import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class QuranRecommendationCard extends StatelessWidget {
  final Map<String, dynamic>? recommendation;

  const QuranRecommendationCard({super.key, this.recommendation});

  @override
  Widget build(BuildContext context) {
    final defaultRecommendation = {
      'surahName': 'QS. Al-Insyirah: 5-6',
      'arabicText': 'فَإِنَّ مَعَ ٱلْعُسْرِ يُسْرًا...',
      'translation': '"Karena sesungguhnya bersama kesulitan ada kemudahan. Sesungguhnya bersama kesulitan ada kemudahan."',
      'reflection': 'Allah SWT mengingatkan bahwa setiap kesulitas pasti diikuti dengan kemudahan. kecemasan yang kamu rasakan adalah bagian dari ujian hidup, dan Allah tidak akan memberikan beban melebihi kemampuan hamba-Nya.',
    };

    final data = recommendation ?? defaultRecommendation;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.v1Success25,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.menu_book,
                  color: AppColors.v1Success500,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rekomendasi Ayat Al-Qur\'an',
                      style: AppTypography.lSemiBold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'untuk menenangkan hati',
                      style: AppTypography.sRegular.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.v1Success25.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.v1Success300, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data['surahName'] ?? 'fallback_value',
                  style: AppTypography.lSemiBold.copyWith(
                    color: AppColors.v1Success800,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    data['arabicText'] ?? 'fallback_value',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.v1Success800,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data['translation'] ?? 'fallback_value',
                    style: AppTypography.sMedium.copyWith(
                      color: AppColors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.v1Success50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hikmah & Refleksi:',
                        style: AppTypography.mSemiBold.copyWith(
                          color: Colors.green.shade900,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        data['reflection'] ?? 'fallback_value',
                        style: AppTypography.sMedium.copyWith(
                          color: Colors.green.shade900,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle, size: 20),
                  label: Text(
                    'Dengar Audio',
                    style: AppTypography.sSemiBold.copyWith(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.v1Primary500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark,
                  size: 20,
                  color: AppColors.v1Primary500,
                ),
                label: Text(
                  'Simpan',
                  style: AppTypography.sSemiBold.copyWith(
                    color: AppColors.v1Primary500,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.v1Primary500, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
