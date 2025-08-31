import 'package:get/get.dart';
import '../../../data/modules/connection_type.dart';
import '../../../data/modules/mood_type.dart';
import '../../../data/modules/need_type.dart';
import '../../../routes/app_pages.dart';
import '../../../services/supabas_service.dart';

class MoodTrackerController extends GetxController {
  var selectedMoodValue = ''.obs;
  var selectedNeedValues = <String>[].obs;
  var selectedConnectionValue = ''.obs;
  var isLoading = false.obs;
  var isSubmitting = false.obs;

  var moodTypes = <MoodType>[].obs;
  var needTypes = <NeedType>[].obs;
  var connectionTypes = <ConnectionType>[].obs;

  bool get isFormValid => selectedMoodValue.value.isNotEmpty;
  bool get isFormCompletelyValid =>
      selectedMoodValue.value.isNotEmpty &&
      selectedNeedValues.isNotEmpty &&
      selectedConnectionValue.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    loadMasterData();
    checkTodayEntry();
  }

  Future<void> loadMasterData() async {
    try {
      isLoading.value = true;
      
      final results = await Future.wait([
        SupabaseService.getMoodTypes(),
        SupabaseService.getNeedTypes(),
        SupabaseService.getConnectionTypes(),
      ]);

      moodTypes.value = results[0] as List<MoodType>;
      needTypes.value = results[1] as List<NeedType>;
      connectionTypes.value = results[2] as List<ConnectionType>;
      
    } catch (e) {
      Get.snackbar(
        'Error!', 
        'Gagal memuat data: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkTodayEntry() async {
    try {
      // Check if user is signed in
      if (!SupabaseService.isSignedIn) {
        // User not signed in, redirect to login
        print('User not signed in');
        return;
      }

      final hasEntry = await SupabaseService.hasTodayEntry();
      if (hasEntry) {
        Get.snackbar(
          'Info', 
          'Kamu sudah mengisi mood tracker hari ini!',
          snackPosition: SnackPosition.TOP,
        );
        // Optionally navigate to home or show today's entry
      }
    } catch (e) {
      print('Error checking today entry: $e');
    }
  }

  // Methods for selections
  void selectMood(String moodValue) {
    selectedMoodValue.value = moodValue;
  }

  void toggleNeed(String needValue) {
    if (selectedNeedValues.contains(needValue)) {
      selectedNeedValues.remove(needValue);
    } else {
      selectedNeedValues.add(needValue);
    }
  }

  void selectConnection(String connectionValue) {
    selectedConnectionValue.value = connectionValue;
  }

  Future<void> submitMoodTracker() async {
    if (!isFormCompletelyValid) {
      Get.snackbar(
        'Peringatan!', 
        'Mohon lengkapi semua pilihan',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      // Check if user is signed in
      if (!SupabaseService.isSignedIn) {
        Get.snackbar(
          'Error!', 
          'Silakan login terlebih dahulu',
          snackPosition: SnackPosition.TOP,
        );
        // Navigate to login page
        // Get.toNamed(Routes.LOGIN);
        return;
      }

      // Check if already submitted today
      final hasEntry = await SupabaseService.hasTodayEntry();
      if (hasEntry) {
        Get.snackbar(
          'Info', 
          'Kamu sudah mengisi mood tracker hari ini!',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      await SupabaseService.createMoodEntry(
        moodValue: selectedMoodValue.value,
        needValues: selectedNeedValues.toList(),
        connectionValue: selectedConnectionValue.value,
      );

      Get.snackbar(
        'Berhasil!', 
        'Mood tracker berhasil disimpan',
        snackPosition: SnackPosition.TOP,
      );
      
      Get.toNamed(Routes.home);
      resetForm();

    } catch (e) {
      Get.snackbar(
        'Error!', 
        'Gagal menyimpan mood tracker: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void resetForm() {
    selectedMoodValue.value = '';
    selectedNeedValues.clear();
    selectedConnectionValue.value = '';
  }

  @override
  void onClose() {
    super.onClose();
  }
}
