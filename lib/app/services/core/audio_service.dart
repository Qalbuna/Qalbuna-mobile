import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioService extends GetxController {
  static AudioService get instance => Get.find<AudioService>();
  
  late AudioPlayer _audioPlayer;
  
  var isPlaying = false.obs;
  var isPaused = false.obs;
  var isLoading = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var currentUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  void _initializePlayer() {
    _audioPlayer = AudioPlayer();
    
    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying.value = state == PlayerState.playing;
      isPaused.value = state == PlayerState.paused;
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      totalDuration.value = duration;
    });

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((Duration position) {
      currentPosition.value = position;
    });

    // Listen to player completion
    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      isPaused.value = false;
      currentPosition.value = Duration.zero;
    });
  }

  Future<bool> playFromUrl(String url) async {
    try {
      isLoading.value = true;
      
      // Stop current audio if playing different URL
      if (currentUrl.value != url && isPlaying.value) {
        await stop();
      }
      
      currentUrl.value = url;
      
      // Play the audio
      await _audioPlayer.play(UrlSource(url));
      
      Get.snackbar(
        'Audio',
        'Memulai murotal...',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
      
      return true;
    } catch (e) {
      print('Error playing audio: $e');
      Get.snackbar(
        'Error',
        'Gagal memutar audio: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  Future<void> resume() async {
    try {
      await _audioPlayer.resume();
    } catch (e) {
      print('Error resuming audio: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      currentPosition.value = Duration.zero;
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print('Error seeking audio: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      print('Error setting volume: $e');
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}