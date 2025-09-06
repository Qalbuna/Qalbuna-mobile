import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/journal_controller.dart';
import '../widgets/journal_menu_widget.dart';

class JournalView extends GetView<JournalController> {
  const JournalView({super.key});
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
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qalbuna Jurnal',
              style: AppTypography.h5SemiBold.copyWith(color: AppColors.white),
            ),
            SizedBox(height: 6),
            Text(
              'Certakanlah Perasaanmu ❤️',
              style: AppTypography.sMedium.copyWith(color: AppColors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.v1Primary500,
        toolbarHeight: 80,
        actions: [
          JournalMenuWidget(
            onAddJournal: controller.addJournal,
            onDeleteJournal: controller.deleteJournal,
          ),
        ],
      ),
      body: const Center(
        child: Text('JournalView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
