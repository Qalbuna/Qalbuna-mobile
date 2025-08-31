import 'package:get/get.dart';
import '../../../data/modules/connection_type.dart';
import '../../../data/modules/mood_type.dart';
import '../../../data/modules/need_type.dart';
import '../../../routes/app_pages.dart';
import '../../../services/supabas_service.dart';

class MoodTrackerController extends GetxController {
  var selectedMoodValue = ''.obs;
  var selectedNeedValue = ''.obs;
  var selectedConnectionValue = ''.obs;
  var isLoading = false.obs;
  var isSubmitting = false.obs;

  var moodTypes = <MoodType>[].obs;
  var needTypes = <NeedType>[].obs;
  var connectionTypes = <ConnectionType>[].obs;

  bool get isFormValid => selectedMoodValue.value.isNotEmpty;
  bool get isFormCompletelyValid =>
      selectedMoodValue.value.isNotEmpty &&
      selectedNeedValue .value.isNotEmpty &&
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

  void selectMood(String moodValue) {
    selectedMoodValue.value = moodValue;
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
    selectedNeedValue.value = '';
    selectedConnectionValue.value = '';
  }
}
