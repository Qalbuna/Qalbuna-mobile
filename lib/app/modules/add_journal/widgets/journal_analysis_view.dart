import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/modules/add_journal/widgets/journal_analysis_card.dart';
import '../../../data/models/journal_model.dart';
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
            JournalAnalysisCard(journal: journal),
            const SizedBox(height: 24),
            EmotionAnalysisCard(analysisResult: analysisResult),
          ],
        ),
      ),
    );
  }
}
