import 'package:get/get.dart';
import '../../../data/models/connection_type.dart';
import '../../../data/models/mood_type.dart';
import '../../../data/models/need_type.dart';
import '../../../routes/app_pages.dart';
import '../../../services/core/supabas_service.dart';

class MoodTrackerController extends GetxController {
  var selectedMoodValue = ''.obs;
  var selectedNeedValue = ''.obs;
  var selectedConnectionValue = ''.obs;
  var isLoading = false.obs;
  var isSubmitting = false.obs;

  var moodTypes = <MoodType>[].obs;
  var allNeedTypes = <NeedType>[].obs;
  var connectionTypes = <ConnectionType>[].obs;

  List<NeedType> get filteredNeedTypes {
    if (selectedMoodValue.value.isEmpty) {
      return [];
    }
    return allNeedTypes
        .where((need) => need.moodValue == selectedMoodValue.value)
        .toList();
  }

  bool get isFormValid => selectedMoodValue.value.isNotEmpty;
  bool get isFormCompletelyValid =>
      selectedMoodValue.value.isNotEmpty &&
      selectedNeedValue.value.isNotEmpty &&
      selectedConnectionValue.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    loadMasterData();
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
      allNeedTypes.value = results[1] as List<NeedType>;
      connectionTypes.value = results[2] as List<ConnectionType>;
    } catch (e) {
      throw Exception('Failed to fetch connection types: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectMood(String moodValue) {
    selectedMoodValue.value = moodValue;
    selectedNeedValue.value = '';
  }

  void selectNeed(String needValue) {
    selectedNeedValue.value = needValue;
  }

  void selectConnection(String connectionValue) {
    selectedConnectionValue.value = connectionValue;
  }

  Future<void> submitMoodTracker() async {
    try {
      isSubmitting.value = true;

      await SupabaseService.createMoodEntry(
        moodValue: selectedMoodValue.value,
        needValues: [selectedNeedValue.value],
        connectionValue: selectedConnectionValue.value,
      );
      Get.toNamed(Routes.bottomNavigation);
      resetForm();
    } catch (e) {
      throw Exception('Gagal menyimpan mood tracker:: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  void resetForm() {
    selectedMoodValue.value = '';
    selectedNeedValue.value = '';
    selectedConnectionValue.value = '';
  }
}
