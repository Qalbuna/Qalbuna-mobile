import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/journal_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/core/journal_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../journal/controllers/journal_controller.dart';
import '../widgets/journal_analysis_view.dart';

class AddJournalController extends GetxController {
  final textController = TextEditingController();
  final titleController = TextEditingController();
  var characterCount = 0.obs;
  var isFieldFocused = false.obs;
  var isLoading = false.obs;
  var isSaving = false.obs;
  var isAnalyzing = false.obs;

  String get userId => Supabase.instance.client.auth.currentUser?.id ?? '';

  void onTextChanged(String text) {
    characterCount.value = text.length;
  }

  void onTitleChanged(String title) {
    update();
  }

  void onTitleFocus() {
    isFieldFocused.value = true;
    update();
  }

  void onContentFocus() {
    isFieldFocused.value = true;
    update();
  }

  Color getBorderColor() {
    return isFieldFocused.value ? AppColors.v1Primary500 : AppColors.v1Gray300;
  }

  Future<void> saveJournal() async {
    if (titleController.text.trim().isEmpty ||
        textController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Judul dan isi jurnal tidak boleh kosong',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
      return;
    }

    try {
      isSaving.value = true;
      final journal = JournalModel(
        userId: userId,
        title: titleController.text.trim(),
        content: textController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await JournalService.addJournal(journal);
      clearForm();
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(Routes.journal);
      Get.offAllNamed(Routes.bottomNavigation);
      Future.delayed(const Duration(milliseconds: 100), () async {
        try {
          final bottomNavController = Get.find<BottomNavigationController>();
          bottomNavController.setIndex(1);

          final journalController = Get.find<JournalController>();
          await journalController.refreshJournals();
          Get.snackbar(
            'Alhamdulillah',
            'Tantangan hari ini selesai🌟',
            backgroundColor: AppColors.white,
            colorText: AppColors.black,
          );
        } catch (e) {
          throw Exception('Error setting navigation: $e');
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan jurnal: ${e.toString()}');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> analyzeJournal() async {
    if (titleController.text.trim().isEmpty ||
        textController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Judul dan isi jurnal tidak boleh kosong',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
      return;
    }
    try {
      isAnalyzing.value = true;
      await Future.delayed(const Duration(seconds: 2));
      final journal = JournalModel(
        userId: userId,
        title: titleController.text.trim(),
        content: textController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final analysisResult = {
        'dominantEmotion': 'Sedih',
        'description':
            'Berdasarkan analisis teks, terdeteksi perasaan sedih yang cukup dalam dengan indikator kata-kata seperti "lelah", "kecewa", "sendirian", "kosong", dan "tidak ada artinya".',
        'sadness': 60,
        'emptiness': 23,
        'lonely': 17,
        'timestamp': DateTime.now(),
      };
      Get.to(
        () => JournalAnalysisView(
          journal: journal,
          analysisResult: analysisResult,
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menganalisis jurnal: ${e.toString()}',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
    } finally {
      isAnalyzing.value = false;
    }
  }

  void clearForm() {
    titleController.clear();
    textController.clear();
    characterCount.value = 0;
    isFieldFocused.value = false;
    update();
  }

  @override
  void onClose() {
    textController.dispose();
    titleController.dispose();
    super.onClose();
  }
}
