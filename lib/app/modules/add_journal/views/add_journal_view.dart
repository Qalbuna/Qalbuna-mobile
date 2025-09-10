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
                JournalTextField(
                  controller: controller.textController,
                  onChanged: controller.onTextChanged,
                ),
                const SizedBox(height: 24),
                Text(
                  'Pilih untuk mendapatkan petikan Qur\'an sesuai suasana hatimu',
                  style: AppTypography.sMedium.copyWith(
                    color: AppColors.v1Neutral600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                JournalActionButton(
                  label: '✨ Simpan Journal',
                  description: 'Simpan sebagai kenangan pribadi',
                  isOutlined: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 18),
                JournalActionButton(
                  label: '❤︎ Analisis Perasaanku',
                  description: 'Dapatkan ayat yang menyentuh hati',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
