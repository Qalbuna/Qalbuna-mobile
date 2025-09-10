import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_colors.dart';

class AddJournalController extends GetxController {
  final textController = TextEditingController();
  final titleController = TextEditingController();
  var characterCount = 0.obs;
  var isFieldFocused = false.obs;

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

  void saveJournal() {
    if (titleController.text.isEmpty || textController.text.isEmpty) {
      Get.snackbar('Error', 'Judul dan isi jurnal tidak boleh kosong');
      return;
    }

    Get.snackbar('Sukses', 'Jurnal berhasil disimpan');
    Get.back();
  }

  void analyzeJournal() {
    Get.snackbar('Info', 'Fitur analisis akan segera hadir');
  }

  @override
  void onClose() {
    textController.dispose();
    titleController.dispose();
    super.onClose();
  }
}