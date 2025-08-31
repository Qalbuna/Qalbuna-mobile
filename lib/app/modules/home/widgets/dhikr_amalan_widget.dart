import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

class DhikrAmalanWidget extends StatelessWidget {
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
          Text(
            'Dzikir Tasbih 33x Setelah Shalat',
            style: AppTypography.h5Bold.copyWith(
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dzikir tasbih 33 kali setelah shalat adalah bagian dari dzikir yang sangat dianjurkan oleh Rasulullah...',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral600,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.v1Primary500,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Mulai Dzikir',
                style: AppTypography.sMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}