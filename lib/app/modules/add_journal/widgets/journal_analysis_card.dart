import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../../../data/models/journal_model.dart';

class JournalAnalysisCard extends StatelessWidget {
  final JournalModel journal;

  const JournalAnalysisCard({
    super.key,
    required this.journal,
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
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.v1Primary500,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.article,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jurnal Hari Ini',
                      style: AppTypography.lSemiBold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(journal.createdAt ?? DateTime.now()),
                      style: AppTypography.sRegular.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Journal content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.v1Primary25,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Judul: ${journal.title}',
                  style: AppTypography.lSemiBold.copyWith(
                    color: AppColors.v1Neutral900,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  journal.content,
                  style: AppTypography.mMedium.copyWith(
                    color: AppColors.v1Gray700,
                    height: 1.5,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Timestamp
          Row(
            children: [
              Icon(
                Icons.edit,
                size: 16,
                color: AppColors.v1Gray500,
              ),
              const SizedBox(width: 8),
              Text(
                'Ditulis baru saja',
                style: AppTypography.sRegular.copyWith(
                  color: AppColors.v1Gray500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final weekdays = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    final months = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
                   'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    
    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month]} ${date.year}';
  }
}