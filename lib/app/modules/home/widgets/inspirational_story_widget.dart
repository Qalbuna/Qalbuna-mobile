import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

import 'kisah.dart';

class InspirationalStoryWidget extends StatelessWidget {
  const InspirationalStoryWidget({super.key});

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
          Row(
            children: [
              Icon(Icons.auto_stories, color: AppColors.v1Primary500, size: 18),
              const SizedBox(width: 8),
              Text(
                'Kisah Inspiratif',
                style: AppTypography.sSemiBold.copyWith(
                  color: AppColors.v1Primary500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Ketika Nabi Yunus AS. di dalam Kegelapan Perut Ikan Paus',
            style: AppTypography.h5Bold.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 8),
          Text(
            'Di dalam perut ikan paus, Nabi Yunus berada dalam tiga lapis kegelapan: kegelapan malam, kegelapan laut, dan kegelapan perut ikan. Dalam',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral600,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Get.to(() => const Kisah());
            },
            child: Row(
              children: [
                Text(
                  'Baca Kisah Lengkap',
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
}
