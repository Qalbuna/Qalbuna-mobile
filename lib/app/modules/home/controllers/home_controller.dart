import 'package:get/get.dart';
import '../../../data/modules/connection_type.dart';
import '../../../data/modules/mood_type.dart';
import '../../../data/modules/need_type.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../../services/supabas_service.dart';

class HomeController extends GetxController {
  var currentMoodData = Rx<Map<String, dynamic>?>(null);
  var isLoading = false.obs;
  var selectedDate = DateTime.now().obs;

  var moodTypes = <MoodType>[].obs;
  var needTypes = <NeedType>[].obs;
  var connectionTypes = <ConnectionType>[].obs;

  final authServices = AuthServices();
  var userName = 'User'.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadMasterData();
    loadTodayMood();
  }

  @override
  void onReady() {
    super.onReady();
    loadUserData();
  }

  Future<void> loadMasterData() async {
    try {
      final results = await Future.wait([
        SupabaseService.getMoodTypes(),
        SupabaseService.getNeedTypes(),
        SupabaseService.getConnectionTypes(),
      ]);

      moodTypes.value = results[0] as List<MoodType>;
      needTypes.value = results[1] as List<NeedType>;
      connectionTypes.value = results[2] as List<ConnectionType>;
    } catch (e) {
      print('Error loading master data: $e');
    }
  }

  void loadUserData() {
    try {
      final user = authServices.getCurrentUser();
      if (user != null) {
        String? displayName = authServices.getCurrentUserDisplayName();

        if (displayName != null && displayName.isNotEmpty) {
          userName.value = displayName.split(' ').first;
        }

        userEmail.value = authServices.getCurrentUserEmail() ?? '';
      } else {
        userName.value = 'User';
        userEmail.value = '';
      }
    } catch (e) {
      userName.value = 'User';
      userEmail.value = '';
    }
  }

  Future<void> loadTodayMood() async {
    try {
      isLoading.value = true;
      if (!SupabaseService.isSignedIn) {
        currentMoodData.value = null;
        return;
      }
      final todayEntry = await SupabaseService.getTodayMoodEntry();

      if (todayEntry != null) {
        currentMoodData.value = todayEntry;
      } else {
        currentMoodData.value = null;
      }
    } catch (e) {
      currentMoodData.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> loadAllTodayMoods() async {
    try {
      if (!SupabaseService.isSignedIn) return [];

      return await SupabaseService.getMoodEntriesByDate(DateTime.now());
    } catch (e) {
      return [];
    }
  }
  
  String getMoodEmoji(String moodValue) {
    final mood = moodTypes.firstWhereOrNull((m) => m.value == moodValue);
    return mood?.emoji ?? '😊';
  }

  String getMoodLabel(String moodValue) {
    final mood = moodTypes.firstWhereOrNull((m) => m.value == moodValue);
    return mood?.label ?? 'Baik';
  }

  String getNeedIcon(String needValue) {
    final need = needTypes.firstWhereOrNull((n) => n.value == needValue);
    return need?.icon ?? '🤲';
  }

  String getNeedLabel(String needValue) {
    final need = needTypes.firstWhereOrNull((n) => n.value == needValue);
    return need?.label ?? 'Ketenangan';
  }

  String getConnectionIcon(String connectionValue) {
    final connection = connectionTypes.firstWhereOrNull(
      (c) => c.value == connectionValue,
    );
    return connection?.icon ?? '⭐';
  }

  String getConnectionLabel(String connectionValue) {
    final connection = connectionTypes.firstWhereOrNull(
      (c) => c.value == connectionValue,
    );
    return connection?.label ?? 'Merasa dekat dan terhubung';
  }

  Future<void> refreshTodayMood() async {
    await loadTodayMood();
  }

  void navigateToMoodTracker() {
    Get.offAllNamed(Routes.moodTracker);
  }
}
