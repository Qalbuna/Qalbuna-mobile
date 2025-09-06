import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/add_journal_controller.dart';
import '../widgets/date_card.dart';
import '../widgets/journal_action_buttton.dart';
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
          child: IntrinsicHeight(
            child: Column(
              children: [
                DateCard(),
                const SizedBox(height: 32),
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
    );
  }

  Widget _buildTextFieldSection() {
    return JournalTextField(
      controller: controller.textController,
      onChanged: controller.onTextChanged,
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
