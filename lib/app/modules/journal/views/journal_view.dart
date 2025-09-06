import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/journal_controller.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Qalbuna Jurnal',
                  style: AppTypography.h5SemiBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Certakanlah Perasaanmu Hari ini ❤️',
                  style: AppTypography.sMedium.copyWith(color: AppColors.white),
                ),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Get.toNamed(Routes.addJournal);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.2 * 255).toInt()),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.add, 
                    color: AppColors.white, 
                    size: 24
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.v1Primary500,
        toolbarHeight: 80,
      ),
      body: const Center(
        child: Text('JournalView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
