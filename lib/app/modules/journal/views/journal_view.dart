import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/journal_controller.dart';
import '../widgets/empty.dart';
import '../widgets/jurnal_card.dart';

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
                onTap: () async {
                  await Get.toNamed(Routes.addJournal);
                  controller.forceRefresh();
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
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.v1Primary500,
        toolbarHeight: 80,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.journals.isEmpty) {
          return const Empty();
        }
        return RefreshIndicator(
          onRefresh: controller.forceRefresh,
          color: AppColors.v1Primary500,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.journals.length,
            itemBuilder: (context, index) {
              final journal = controller.journals[index];
              return JournalCard(
                journal: journal,
                onTap: () {},
                onDelete: () {
                  controller.deleteJournal(journal.id!);
                },
              );
            },
          ),
        );
      }),
    );
  }
}
