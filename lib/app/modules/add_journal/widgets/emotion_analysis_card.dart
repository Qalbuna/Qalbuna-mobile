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
          // Header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.psychology,
                  color: Colors.orange.shade600,
                  size: 24,
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
                        color: AppColors.v1Neutral900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Dianalisis dengan AI',
                      style: AppTypography.sRegular.copyWith(
                        color: AppColors.v1Gray600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Dominant Emotion
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.orange.shade200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade600,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Perasaan Dominan: ${analysisResult['dominantEmotion'] ?? 'Cemas'}',
                      style: AppTypography.mSemiBold.copyWith(
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  analysisResult['description'] ?? 
                  'Berdasarkan analisis teks, terdeteksi tingkat kecemasan yang tinggi dengan indikator kata-kata seperti "berat", "cemas", "tidak tenang", dan "tidak tahu".',
                  style: AppTypography.sRegular.copyWith(
                    color: Colors.orange.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Emotion Percentages
          Row(
            children: [
              _buildEmotionPercentage(
                'Stress',
                analysisResult['stress'] ?? 75,
                Colors.red.shade500,
              ),
              const SizedBox(width: 16),
              _buildEmotionPercentage(
                'Cemas',
                analysisResult['anxiety'] ?? 85,
                Colors.orange.shade500,
              ),
              const SizedBox(width: 16),
              _buildEmotionPercentage(
                'Sedih',
                analysisResult['sadness'] ?? 60,
                Colors.yellow.shade600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionPercentage(String label, int percentage, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.sRegular.copyWith(
              color: AppColors.v1Gray600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$percentage%',
            style: AppTypography.lSemiBold.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}