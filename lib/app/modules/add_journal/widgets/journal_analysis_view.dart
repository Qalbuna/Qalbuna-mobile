import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/models/journal_model.dart';
import '../../../shared/constant/uidata.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../widgets/emotion_analysis_card.dart';

class JournalAnalysisView extends StatelessWidget {
  final JournalModel journal;
  final Map<String, dynamic> analysisResult;

  const JournalAnalysisView({
    super.key,
    required this.journal,
    required this.analysisResult,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.v1Primary500,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jurnal Harian',
          style: AppTypography.h5SemiBold.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.v1Primary500,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: AppColors.v1Gray50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                  Row(
                    children: [
                      Image.network(edit, width: 20, height: 20),
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
            ),
            const SizedBox(height: 24),
            EmotionAnalysisCard(analysisResult: analysisResult),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final weekdays = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    final months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month]} ${date.year}';
  }
}
