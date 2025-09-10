import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/journal_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/core/journal_service.dart';
import '../../../shared/theme/app_colors.dart';

class JournalController extends GetxController {
  var journals = <JournalModel>[].obs;
  var isLoading = false.obs;

  String get userId => Supabase.instance.client.auth.currentUser?.id ?? '';

  @override
  void onInit() {
    super.onInit();
    loadJournals();
  }

  @override
  void onReady() {
    super.onReady();
    ever(journals, (_) {
      update();
    });
  }

  Future<void> loadJournals() async {
    try {
      isLoading.value = true;
      final loadedJournals = await JournalService.getJournals(userId);
      journals.value = loadedJournals;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat jurnal: ${e.toString()}',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void addJournal() {
    Get.toNamed(Routes.addJournal);
  }

  Future<void> refreshJournals() async {
    await loadJournals();
  }

  Future<void> forceRefresh() async {
    journals.clear();
    await loadJournals();
  }

  Future<void> deleteJournal(String journalId) async {
    try {
      await JournalService.deleteJournal(journalId);
      journals.removeWhere((journal) => journal.id == journalId);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus jurnal: ${e.toString()}',
        backgroundColor: AppColors.v1Error500,
        colorText: AppColors.white,
      );
    }
  }
}
