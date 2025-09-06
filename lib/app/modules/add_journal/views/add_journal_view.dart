import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/add_journal_controller.dart';
import '../widgets/journal_Action_buttton.dart';
import '../widgets/journal_text_field.dart';

class AddJournalView extends GetView<AddJournalController> {
  const AddJournalView({super.key});

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
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         MediaQuery.of(context).padding.top - 
                         80 - // AppBar height
                         MediaQuery.of(context).padding.bottom - 
                         32, // Padding
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  _buildDateSection(),
                  const SizedBox(height: 16),
                  _buildPromptSection(),
                  const SizedBox(height: 16),
                  _buildTextFieldSection(),
                  const SizedBox(height: 12),
                  _buildQuranSuggestion(),
                  const SizedBox(height: 12),
                  _buildActionButtons(),
                  const SizedBox(height: 12),
                  _buildAnalysisButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    return GetBuilder<AddJournalController>(
      builder: (ctrl) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text('Hari ini', style: AppTypography.sMedium),
            const SizedBox(height: 4),
            Text(
              ctrl.formattedDate.value,
              style: AppTypography.h5SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              ctrl.formattedTime.value,
              style: AppTypography.sBold.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.v1Primary500.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.favorite, color: AppColors.v1Primary500, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bagaimana harimu?',
                  style: AppTypography.lSemiBold.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tuangkan perasaan dan momen kebahagiamu',
                  style: AppTypography.sMedium.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection() {
    return Container(
      height: 200, // Fixed height untuk TextField
      child: JournalTextField(
        controller: controller.textController,
        onChanged: controller.onTextChanged,
      ),
    );
  }

  Widget _buildQuranSuggestion() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Pilih untuk mendapatkan petikan Qur\'an sesuai suasana hatimu',
        style: AppTypography.sRegular.copyWith(color: Colors.grey[600]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      child: JournalActionButton(
        icon: Icons.bookmark,
        label: 'Simpan Jurnal',
        onPressed: controller.saveJournal,
      ),
    );
  }

  Widget _buildAnalysisButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.analyzeJournal,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[400],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.analytics, color: Colors.white, size: 20),
        label: Text(
          'Analisis Perasaanku',
          style: AppTypography.sMedium.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}