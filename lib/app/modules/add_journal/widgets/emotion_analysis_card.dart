import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class EmotionAnalysisCard extends StatelessWidget {
  final Map<String, dynamic> analysisResult;

  const EmotionAnalysisCard({
    super.key,
    required this.analysisResult,
  });

  @override
  Widget build(BuildContext context) {
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
                  color: AppColors.v1Orange25,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.tips_and_updates      ,
                  color: AppColors.v1Orange500,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil Analisis Emosi',
                      style: AppTypography.lSemiBold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dianalisis dengan AI',
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
              color: AppColors.v1Orange25,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.v1Orange500,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.v1Orange500,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Perasaan Dominan: ${analysisResult['dominantEmotion'] ?? 'Cemas'}',
                      style: AppTypography.mSemiBold.copyWith(
                        color: AppColors.v1Orange700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  analysisResult['description'] ?? 
                  'Berdasarkan analisis teks, terdeteksi tingkat kecemasan yang tinggi dengan indikator kata-kata seperti "berat", "cemas", "tidak tenang", dan "tidak tahu".',
                  style: AppTypography.sRegular.copyWith(
                    color: AppColors.v1Orange700,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildEmotionPercentage(
                'Stress',
                analysisResult['stress'] ?? 75,
                AppColors.v1Error500,
              ),
              const SizedBox(width: 16),
              _buildEmotionPercentage(
                'Cemas',
                analysisResult['anxiety'] ?? 85,
                AppColors.v1Orange500,
              ),
              const SizedBox(width: 16),
              _buildEmotionPercentage(
                'Sedih',
                analysisResult['sadness'] ?? 60,
                AppColors.v1Gold500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionPercentage(String label, int percentage, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), 
          borderRadius: BorderRadius.circular(8),
        ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.sRegular.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$percentage%',
            style: AppTypography.lSemiBold.copyWith(
              color: color,
            ),
          ),
        ],
      ),)
    );
  }
}