import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../data/models/connection_type.dart';
import '../../../data/models/mood_type.dart';
import '../../../data/models/need_type.dart';
import '../../../data/models/prophet_story.dart';
import '../../../data/models/verse.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth/auth_services.dart';
import '../../../services/core/audio_service.dart';
import '../../../services/core/prophet_story_service.dart';
import '../../../services/core/quran_service.dart';
import '../../../services/core/supabas_service.dart';

class HomeController extends GetxController {
  // Mood and general data
  var currentMoodData = Rx<Map<String, dynamic>?>(null);
  var isLoading = false.obs;
  var selectedDate = DateTime.now().obs;

  // Verse related
  var currentVerse = Rx<Verse?>(null);
  var currentVerseAudioUrl = Rx<String?>(null);
  var isVerseFavorited = false.obs;
  var isVerseLoading = false.obs;
  var isAudioLoading = false.obs;

  // Dhikr related
  var isDhikrActive = false.obs;
  var dhikrCount = 1.obs;
  static const int dhikrTarget = 3;

  // Video related - UPDATED
  var currentProphetStory = Rx<ProphetStory?>(null);
  var isVideoLoading = false.obs;
  var isVideoPlaying = false.obs;
  var currentVideoId = ''.obs;
  YoutubePlayerController? youtubeController;

  // Master data
  var moodTypes = <MoodType>[].obs;
  var needTypes = <NeedType>[].obs;
  var connectionTypes = <ConnectionType>[].obs;

  // Services
  final authServices = AuthServices();
  late AudioService audioService;

  // User data
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

  // Master Data Loading
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
      throw Exception('Error loading master data: $e');
    }
  }

  // User Data Loading
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
      throw Exception('Error loading user data: $e');
    }
  }

  // Mood Related Methods
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
        await loadVideoForCurrentMood();
      } else {
        currentMoodData.value = null;
        currentVerse.value = null;
        currentProphetStory.value = null;
        _disposeVideoPlayer();
      }
    } catch (e) {
      throw Exception('Error loading today mood: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> loadAllTodayMoods() async {
    try {
      if (!SupabaseService.isSignedIn) return [];
      return await SupabaseService.getMoodEntriesByDate(DateTime.now());
    } catch (e) {
      throw Exception('Error loading all today moods: $e');
    }
  }

  Future<void> refreshTodayMood() async {
    await loadTodayMood();
  }

  void navigateToMoodTracker() {
    Get.offAllNamed(Routes.moodTracker);
  }

  // Verse Related Methods
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
      throw Exception('Error getting another verse: $e');
    }
  }

  void navigateToVerseDetail() {
    // Get.toNamed(Routes.verseDetail, arguments: currentVerse.value);
  }

  // Audio Related Methods
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

  // Dhikr Related Methods
  void startDhikr() {
    isDhikrActive.value = true;
    dhikrCount.value = 0;
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
    dhikrCount.value = 0;
  }

  void _completeDhikr() {
    Get.snackbar(
      'Alhamdulillah',
      'Dzikir telah selesai. Barakallahu fiik.',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
    Future.delayed(Duration(seconds: 1), resetDhikr);
  }

  // Video Related Methods 
  Future<void> loadVideoForCurrentMood() async {
    try {
      isVideoLoading.value = true;

      if (currentMoodData.value == null) {
        currentProphetStory.value = null;
        _disposeVideoPlayer();
        return;
      }

      final moodData = currentMoodData.value!;
      final entry = moodData['entry'] as Map<String, dynamic>;
      final moodType = entry['mood_types'] as Map<String, dynamic>;
      final emotionValue = moodType['value'] as String;

      final story = await ProphetStoryService.getStoryByEmotion(emotionValue);

      if (story != null) {
        currentProphetStory.value = story;
        // Don't initialize player here, let the widget handle it
      } else {
        currentProphetStory.value = null;
        _disposeVideoPlayer();
      }
    } catch (e) {
      throw Exception('Error loading video: $e');
    } finally {
      isVideoLoading.value = false;
    }
  }

  void initializeVideoPlayer(String videoId) {
    try {
      // Dispose existing controller first
      _disposeVideoPlayer();

      // Validate YouTube ID
      if (videoId.isEmpty) {
        throw Exception('Empty YouTube ID provided');
      }

      if (!RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(videoId)) {
        throw Exception('Invalid YouTube ID format: $videoId');
      }

     youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: true,
          captionLanguage: 'id',
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          startAt: 0,
          hideControls: false,
        ),
      );

      currentVideoId.value = videoId;
      isVideoPlaying.value = false;
    } catch (e) {
      throw Exception('Error initializing video player: $e');
    }
  }

  void onVideoReady(String storyId) {
    try {
      _recordVideoView(storyId);
    } catch (e) {
      throw Exception('Error on video ready: $e');
    }
  }

  void onVideoEnded() {
    isVideoPlaying.value = false;
  }

  void _recordVideoView(String storyId) {
    try {
      ProphetStoryService.recordVideoView(
        prophetStoryId: storyId,
        moodEntryId: currentMoodData.value?['entry']?['id'],
      );
    } catch (e) {
      throw Exception('Error recording video view: $e');
    }
  }

  void _disposeVideoPlayer() {
    try {
      if (youtubeController != null) {
        youtubeController!.dispose();
        youtubeController = null;
      }
      currentVideoId.value = '';
      isVideoPlaying.value = false;
    } catch (e) {
      throw Exception('Error disposing video player: $e');
    }
  }

  void openYoutubeVideo() {
    if (currentProphetStory.value != null) {
      final videoId = currentProphetStory.value!.youtubeId;
      final url = 'https://www.youtube.com/watch?v=$videoId';
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  void playVideo() {
    try {
      if (youtubeController != null && youtubeController!.value.isReady) {
        youtubeController!.play();
        isVideoPlaying.value = true;
      } else {
        throw Exception('Video controller not ready for play');
      }
    } catch (e) {
      throw Exception('Error playing video: $e');
    }
  }

  void pauseVideo() {
    try {
      if (youtubeController != null) {
        youtubeController!.pause();
        isVideoPlaying.value = false;
      }
    } catch (e) {
      throw Exception('Error pausing video: $e');
    }
  }

  void stopVideo() {
    try {
      if (youtubeController != null) {
        youtubeController!.pause();
        youtubeController!.seekTo(Duration.zero);
        isVideoPlaying.value = false;
      }
    } catch (e) {
      throw Exception('Error stopping video: $e');
    }
  }

  @override
  void onClose() {
    _disposeVideoPlayer();
    audioService.dispose();
    super.onClose();
  }
}
