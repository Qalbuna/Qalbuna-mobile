import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class OtherVersesCard extends StatelessWidget {
  final List<Map<String, dynamic>>? verses;

  const OtherVersesCard({super.key, this.verses});

  @override
  Widget build(BuildContext context) {
    final defaultVerses = [
      {
        'surahName': 'QS. Ar-Ra\'d: 28',
        'translation':
            '"...Ingatlah, hanya dengan mengingat Allah hati menjadi tentera."',
        'tags': ['Ketenangan', 'Dzikir'],
        'tagColors': [AppColors.v1Primary100, Colors.purple.shade100],
        'tagTextColors': [AppColors.v1Primary500, Colors.purple.shade600],
      },
      {
        'surahName': 'QS. Al-Baqarah: 286',
        'translation':
            '"...Allah tidak membebani seseorang melainkan sesuai dengan kesanggupannya..."',
        'tags': ['Kekuatan', 'Optimisme'],
        'tagColors': [Colors.green.shade100, Colors.orange.shade100],
        'tagTextColors': [Colors.green.shade600, Colors.orange.shade600],
      },
    ];

    final data = verses ?? defaultVerses;

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
          Text(
            'Ayat Lainnya untuk Kamu',
            style: AppTypography.lSemiBold.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 16),
          ...data.map((verse) => _buildVerseCard(verse)),
        ],
      ),
    );
  }

  Widget _buildVerseCard(Map<String, dynamic> verse) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.v1Gray300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            verse['surahName'] ?? '',
            style: AppTypography.mSemiBold.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 12),
          Text(
            verse['translation'] ?? '',
            style: AppTypography.sRegular.copyWith(
              color: AppColors.v1Gray600,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              (verse['tags'] as List<String>? ?? []).length,
              (index) {
                final tags = verse['tags'] as List<String>;
                final tagColors = verse['tagColors'] as List<Color>;
                final tagTextColors = verse['tagTextColors'] as List<Color>;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: tagColors[index],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tags[index],
                    style: AppTypography.sRegular.copyWith(
                      color: tagTextColors[index],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
