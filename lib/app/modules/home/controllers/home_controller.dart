import 'package:get/get.dart';
import 'package:qalbuna_app/app/data/modules/mood_tracker_data.dart';

import '../../../services/auth_services.dart';

class HomeController extends GetxController {
  // Mock data untuk menampilkan mood yang dipilih
  var currentMoodData = Rx<MoodTrackerData?>(null);
  var isLoading = false.obs;
  var selectedDate = DateTime.now().obs;

  // Auth services untuk mengambil user data
  final authServices = AuthServices();
  var userName = 'User'.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTodayMood();
  }

  @override
  void onReady() {
    super.onReady();
    loadUserData();
  }

  void loadUserData() {
    try {
      final user = authServices.getCurrentUser();

      if (user != null) {
        String? displayName;
        displayName = authServices.getCurrentUserDisplayName();

        if (displayName != null && displayName.isNotEmpty) {
          userName.value = displayName.split(' ').first;
        }
      } else {
        userName.value = 'User';
      }
    } catch (e) {
      userName.value = 'User';
    }
  }

  void loadTodayMood() {
    // Simulasi data mood diganti dengan data dari storage/API
    currentMoodData.value = MoodTrackerData(
      mood: 'takut',
      needs: ['ketenangan'],
      spiritualConnection: 'ingin_mendekat',
      timestamp: DateTime.now(),
      notes: 'Merasa takut dan butuh ketenangan',
    );
  }

  String getMoodEmoji(String mood) {
    switch (mood) {
      case 'sedih':
        return '😢';
      case 'cemas':
        return '😟';
      case 'bersalah':
        return '😔';
      case 'marah':
        return '😡';
      case 'bahagia':
        return '😊';
      case 'takut':
        return '😰';
      default:
        return '😊';
    }
  }

  String getMoodLabel(String mood) {
    switch (mood) {
      case 'sedih':
        return 'Sedih';
      case 'cemas':
        return 'Cemas';
      case 'bersalah':
        return 'Bersalah';
      case 'marah':
        return 'Marah';
      case 'bahagia':
        return 'Bahagia';
      case 'takut':
        return 'Takut';
      default:
        return 'Baik';
    }
  }

  String getNeedIcon(String need) {
    switch (need) {
      case 'ketenangan':
        return '🤲';
      case 'kekuatan':
        return '💪';
      case 'arahan':
        return '🎯';
      case 'kasih_sayang':
        return '🥰';
      default:
        return '🤲';
    }
  }

  String getNeedLabel(String need) {
    switch (need) {
      case 'ketenangan':
        return 'Ketenangan';
      case 'kekuatan':
        return 'Kekuatan';
      case 'arahan':
        return 'Arahan';
      case 'kasih_sayang':
        return 'Kasih Sayang';
      default:
        return 'Ketenangan';
    }
  }
}
