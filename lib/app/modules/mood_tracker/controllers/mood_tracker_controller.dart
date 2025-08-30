import 'package:get/get.dart';
import 'package:qalbuna_app/app/routes/app_pages.dart';

class MoodTrackerController extends GetxController {
  var selectedMood = ''.obs;
  var selectedNeeds = <String>[].obs;
  var selectedConnection = ''.obs;
  var isLoading = false.obs;

  // Computed properties untuk validasi
  bool get isFormValid => selectedMood.value.isNotEmpty;

  bool get isFormCompletelyValid =>
      selectedMood.value.isNotEmpty &&
      selectedNeeds.isNotEmpty &&
      selectedConnection.value.isNotEmpty;

  // Methods for mood selection
  void selectMood(String mood) {
    selectedMood.value = mood;
  }

  // Methods for needs selection (multiple selection)
  void toggleNeed(String need) {
    if (selectedNeeds.contains(need)) {
      selectedNeeds.remove(need);
    } else {
      selectedNeeds.add(need);
    }
  }

  // Methods for spiritual connection
  void selectConnection(String connection) {
    selectedConnection.value = connection;
  }

  // Submit method dengan loading state
  Future<void> submitMoodTracker() async {
    isLoading.value = true;

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      Get.snackbar('Berhasil!', 'Mood kamu telah tersimpan');

      Get.toNamed(Routes.home);
      resetForm();
    } catch (e) {
      // Handle error
      Get.snackbar('Error!', 'Terjadi kesalahan: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    selectedMood.value = '';
    selectedNeeds.clear();
    selectedConnection.value = '';
  }
}
