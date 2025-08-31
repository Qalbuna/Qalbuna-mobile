import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

class VerseRecommendationWidget extends StatelessWidget {
  const VerseRecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.v1Primary100,
            AppColors.v1Primary50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Primary200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.v1Primary500,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Ayat untuk Ketenangan',
                  style: AppTypography.sMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.bookmark_outline,
                color: AppColors.v1Primary500,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
            style: AppTypography.h5Bold.copyWith(
              color: AppColors.black,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            '"Ingatlah, hanya dengan mengingat Allah hati menjadi tenteram."',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral600,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'QS. Ar-Ra\'d: 28',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Primary500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.v1Primary500,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: Text(
                    'Dengar Audio',
                    style: AppTypography.sMedium,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.v1Primary500,
                  side: BorderSide(color: AppColors.v1Primary500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Tafsir',
                  style: AppTypography.sMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}