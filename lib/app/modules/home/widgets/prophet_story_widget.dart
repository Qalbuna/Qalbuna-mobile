import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

class ProphetStoryWidget extends StatelessWidget {
  const ProphetStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.v1Primary900,
            AppColors.v1Primary700,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background pattern/illustration bisa ditambahkan di sini
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.auto_stories,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Nabi Ya\'qub A.S',
                        style: AppTypography.h5Bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.play_circle_outline,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '⭐ Berjalan di Malam Hari ⭐',
                  style: AppTypography.sMedium.copyWith(
                    color: AppColors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nabi Ya\'qub AS - Ketenangan Saat Kehilangan Nabi Yusuf',
                  style: AppTypography.h5Medium.copyWith(
                    color: AppColors.white,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.v1Primary400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Tonton Kisahnya',
                    style: AppTypography.sMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}