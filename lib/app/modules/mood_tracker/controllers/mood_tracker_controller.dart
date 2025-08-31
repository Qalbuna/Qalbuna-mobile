import 'package:get/get.dart';
import 'package:qalbuna_app/app/routes/app_pages.dart';

class MoodTrackerController extends GetxController {
  var selectedMood = ''.obs;
  var selectedNeeds = <String>[].obs;
  var selectedConnection = ''.obs;
  var isLoading = false.obs;

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

  Future<void> submitMoodTracker() async {
    isLoading.value = true;

    try {
      Get.toNamed(Routes.home);
      resetForm();
    } catch (e) {
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
