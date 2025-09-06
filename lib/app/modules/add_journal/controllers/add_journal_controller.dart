import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddJournalController extends GetxController {
  final textController = TextEditingController();

  var formattedDate = ''.obs;
  var formattedTime = ''.obs;
  var characterCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();
  }

  void _updateDateTime() {
    try {
      final now = DateTime.now();
      try {
        formattedDate.value = DateFormat(
          'EEEE, d MMMM yyyy',
          'id_ID',
        ).format(now);
      } catch (e) {
        formattedDate.value = DateFormat('EEEE, d MMMM yyyy').format(now);
      }
    } catch (e) {
      final now = DateTime.now();
      formattedDate.value =
          'Hari ini, ${now.day} ${_getMonthName(now.month)} ${now.year}';
      formattedTime.value =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} WIB';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  void onTextChanged(String text) {
    characterCount.value = text.length;
  }

  void saveJournal() {
    Get.snackbar('Sukses', 'Jurnal berhasil disimpan');
    Get.back();
  }

  void analyzeJournal() {
    Get.snackbar('Info', 'Fitur analisis akan segera hadir');
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
