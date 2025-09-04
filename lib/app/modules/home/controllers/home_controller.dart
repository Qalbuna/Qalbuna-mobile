import 'package:get/get.dart';
import '../../../data/models/connection_type.dart';
import '../../../data/models/mood_type.dart';
import '../../../data/models/need_type.dart';
import '../../../data/models/verse.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth/auth_services.dart';
import '../../../services/core/audio_service.dart';
import '../../../services/core/quran_service.dart';
import '../../../services/core/supabas_service.dart';

class HomeController extends GetxController {
  var currentMoodData = Rx<Map<String, dynamic>?>(null);
  var currentVerse = Rx<Verse?>(null);
  var currentVerseAudioUrl = Rx<String?>(null);
  var isVerseFavorited = false.obs;
  var isLoading = false.obs;
  var isVerseLoading = false.obs;
  var isAudioLoading = false.obs;
  var selectedDate = DateTime.now().obs;
  var isDhikrActive = false.obs;
  var dhikrCount = 1.obs;
  static const int dhikrTarget = 3;

  var moodTypes = <MoodType>[].obs;
  var needTypes = <NeedType>[].obs;
  var connectionTypes = <ConnectionType>[].obs;

  final authServices = AuthServices();
  late AudioService audioService;
  var userName = 'User'.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadMasterData();
    loadTodayMood();
    audioService = Get.put(AudioService());
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
      throw Exception('Gagal memuat data:: $e');
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
        await loadVerseForCurrentMood();
      } else {
        currentMoodData.value = null;
        currentVerse.value = null;
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

  Future<void> loadVerseForCurrentMood() async {
    try {
      isVerseLoading.value = true;

      if (currentMoodData.value == null) return;

      final moodData = currentMoodData.value!;
      final entry = moodData['entry'] as Map<String, dynamic>;
      final moodType = entry['mood_types'] as Map<String, dynamic>;
      final emotionValue = moodType['value'] as String;

      final verse = await QuranService.getRandomVerseByEmotion(emotionValue);

      if (verse != null) {
        currentVerse.value = verse;
        await loadAudioForCurrentVerse();
        currentVerseAudioUrl.value = verse.audioUrl;
        await QuranService.recordVerseReading(
          verseId: verse.id,
          moodEntryId: entry['id'],
        );
      } else {
        currentVerse.value = null;
        currentVerseAudioUrl.value = null;
      }
    } catch (e) {
      throw Exception('Error loading verse: $e');
    } finally {
      isVerseLoading.value = false;
    }
  }

  Future<void> loadAudioForCurrentVerse() async {
    try {
      if (currentVerse.value == null) return;
      isAudioLoading.value = true;
      final audioUrl = await QuranService.getAudioUrl(currentVerse.value!.id);
      if (audioUrl != null) {
        final isAvailable = await QuranService.checkAudioAvailability(audioUrl);
        currentVerseAudioUrl.value = isAvailable ? audioUrl : null;
      } else {
        currentVerseAudioUrl.value = null;
      }
    } catch (e) {
      throw Exception('Error loading audio: $e');
    } finally {
      isAudioLoading.value = false;
    }
  }

  Future<void> getAnotherVerse() async {
    try {
      if (currentMoodData.value == null) return;

      currentVerse.value = null;
      currentVerseAudioUrl.value = null;

      await loadVerseForCurrentMood();
    } catch (e) {
      throw Exception('Gagal memuat ayat lain: $e');
    }
  }

  Future<void> refreshTodayMood() async {
    await loadTodayMood();
  }

  void navigateToMoodTracker() {
    Get.offAllNamed(Routes.moodTracker);
  }

  void navigateToVerseDetail() {
    // Get.toNamed(Routes.verseDetail, arguments: currentVerse.value);
  }
  Future<void> togglePlayPause() async {
    if (currentVerseAudioUrl.value == null) return;

    final isCurrentlyPlaying =
        audioService.isPlaying.value &&
        audioService.currentUrl.value == currentVerseAudioUrl.value;

    if (isCurrentlyPlaying) {
      await audioService.pause();
    } else if (audioService.isPaused.value &&
        audioService.currentUrl.value == currentVerseAudioUrl.value) {
      await audioService.resume();
    } else {
      await audioService.playFromUrl(currentVerseAudioUrl.value!);
    }
  }

  Future<void> stopAudio() async {
    await audioService.stop();
  }

  void startDhikr() {
    isDhikrActive.value = true;
    dhikrCount.value = 1;
  }

  void increaseDhikrCount() {
    if (dhikrCount.value < dhikrTarget) {
      dhikrCount.value++;
      if (dhikrCount.value == dhikrTarget) _completeDhikr();
    }
  }

  void decreaseDhikrCount() {
    if (dhikrCount.value > 1) dhikrCount.value--;
  }

  void resetDhikr() {
    isDhikrActive.value = false;
    dhikrCount.value = 1;
  }

  void _completeDhikr() {
    Get.snackbar(
      'Alhamdulillah!',
      'Dzikir telah selesai. Barakallahu fiik.',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
    Future.delayed(Duration(seconds: 1), resetDhikr);
  }
}
