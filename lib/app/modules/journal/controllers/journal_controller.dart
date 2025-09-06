import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/journal_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/core/journal_service.dart';

class JournalController extends GetxController {
  var journals = <JournalModel>[].obs;
  var isLoading = false.obs;
  
  final String currentUserId = 'user_123';

  @override
  void onInit() {
    super.onInit();
    loadJournals();
  }

  Future<void> loadJournals() async {
    try {
      isLoading.value = true;
      final journalList = await JournalService.getJournals(currentUserId);
      journals.assignAll(journalList);
    } catch (e) {
      Get.snackbar(
        'Error', 
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void addJournal() {
    Get.toNamed(Routes.addJournal);
  }

  Future<void> saveJournal(String title, String content, {String? mood}) async {
    try {
      isLoading.value = true;
      
      final now = DateTime.now();
      final newJournal = JournalModel(
        userId: currentUserId,
        title: title,
        content: content,
        createdAt: now,
        updatedAt: now,
        mood: mood,
      );

      final savedJournal = await JournalService.addJournal(newJournal);
      journals.insert(0, savedJournal);
      
      Get.back();
      Get.snackbar(
        'Sukses', 
        'Jurnal berhasil disimpan',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error', 
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJournal() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Hapus Jurnal'),
        content: const Text('Apakah Anda yakin ingin menghapus semua jurnal?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _deleteAllJournals();
    }
  }

  Future<void> deleteSingleJournal(String journalId) async {
    try {
      isLoading.value = true;
      await JournalService.deleteJournal(journalId);
      journals.removeWhere((journal) => journal.id == journalId);
      
      Get.snackbar(
        'Sukses', 
        'Jurnal berhasil dihapus',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error', 
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _deleteAllJournals() async {
    try {
      isLoading.value = true;
      await JournalService.deleteAllJournals(currentUserId);
      journals.clear();
      
      Get.snackbar(
        'Sukses', 
        'Semua jurnal berhasil dihapus',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error', 
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshJournals() async {
    await loadJournals();
  }
}