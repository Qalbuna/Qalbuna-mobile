import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddJournalController extends GetxController {
  final textController = TextEditingController();
  final titleController = TextEditingController();
  var characterCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onTextChanged(String text) {
    characterCount.value = text.length;
  }

  void onTitleChanged(String title) {
    // Optional: bisa tambah logika untuk title jika diperlukan
    update(); // Update UI jika diperlukan
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
