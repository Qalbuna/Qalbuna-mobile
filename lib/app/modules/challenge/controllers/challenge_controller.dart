import 'package:get/get.dart';
import '../../../data/models/challenge_day_status.dart';

class ChallengeController extends GetxController {
  final RxList<ChallengeDay> challengeDays = <ChallengeDay>[].obs;
  final RxInt currentDay = 1.obs;
  final RxInt totalDays = 7.obs;
  final RxList<int> completedDays = <int>[].obs;
  final RxList<int> passedDays = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeChallengeData();
  }

  void _initializeChallengeData() {
    challengeDays.value = [
      ChallengeDay(
        dayNumber: 1,
        title: 'Hari 1',
        description: 'Baca 1 ayat dengan tenang, lalu tulis 1 kalimat perasaanmu',
        status: ChallengeDayStatus.completed,
        completedDate: DateTime(2025, 7, 7),
      ),
      ChallengeDay(
        dayNumber: 2,
        title: 'Hari 2',
        description: 'Putar 1 sesi Pelukan Qur\'an dan tutup dengan doa pendek',
        status: ChallengeDayStatus.active,
      ),
      ChallengeDay(
        dayNumber: 3,
        title: 'Hari 3',
        description: 'Putar 1 sesi Pelukan Qur\'an dan tutup dengan doa pendek',
        status: ChallengeDayStatus.locked,
      ),
      ChallengeDay(
        dayNumber: 4,
        title: 'Hari 4',
        description: 'Refleksi spiritual dengan menulis 3 hal yang disyukuri hari ini',
        status: ChallengeDayStatus.locked,
      ),
      ChallengeDay(
        dayNumber: 5,
        title: 'Hari 5',
        description: 'Dzikir pagi dan sore dengan penuh kesadaran',
        status: ChallengeDayStatus.locked,
      ),
      ChallengeDay(
        dayNumber: 6,
        title: 'Hari 6',
        description: 'Membaca surat pendek sambil merenungkan maknanya',
        status: ChallengeDayStatus.locked,
      ),
      ChallengeDay(
        dayNumber: 7,
        title: 'Hari 7',
        description: 'Evaluasi perjalanan spiritual selama 7 hari',
        status: ChallengeDayStatus.locked,
      ),
    ];

    completedDays.value = [1];
    currentDay.value = 1;
  }

  void startChallenge(ChallengeDay day) {
    if (day.status == ChallengeDayStatus.active) {
      Get.snackbar(
        'Memulai Tantangan',
        'Memulai tantangan hari ${day.dayNumber}',
      );
      // Navigate to challenge activity
      // Get.toNamed('/challenge/${day.dayNumber}');
    }
  }

  void completeChallenge(int dayNumber) {
    if (!completedDays.contains(dayNumber)) {
      completedDays.add(dayNumber);
    }

    final index = challengeDays.indexWhere((day) => day.dayNumber == dayNumber);
    if (index != -1) {
      challengeDays[index] = ChallengeDay(
        dayNumber: challengeDays[index].dayNumber,
        title: challengeDays[index].title,
        description: challengeDays[index].description,
        status: ChallengeDayStatus.completed,
        completedDate: DateTime.now(),
      );

      _unlockNextDay(dayNumber);
    }
  }

  void _unlockNextDay(int completedDayNumber) {
    final nextDayNumber = completedDayNumber + 1;
    final nextDayIndex = challengeDays.indexWhere((day) => day.dayNumber == nextDayNumber);
    
    if (nextDayIndex != -1 && challengeDays[nextDayIndex].status == ChallengeDayStatus.locked) {
      challengeDays[nextDayIndex] = ChallengeDay(
        dayNumber: challengeDays[nextDayIndex].dayNumber,
        title: challengeDays[nextDayIndex].title,
        description: challengeDays[nextDayIndex].description,
        status: ChallengeDayStatus.active,
      );
      
      currentDay.value = nextDayNumber;
    }
  }

  void markAsPassed(int dayNumber) {
    if (!passedDays.contains(dayNumber)) {
      passedDays.add(dayNumber);
    }

    final index = challengeDays.indexWhere((day) => day.dayNumber == dayNumber);
    if (index != -1) {
      challengeDays[index] = ChallengeDay(
        dayNumber: challengeDays[index].dayNumber,
        title: challengeDays[index].title,
        description: challengeDays[index].description,
        status: ChallengeDayStatus.locked,
      );
    }
  }

  int get totalCompletedDays => completedDays.length;
  double get progressPercentage => (totalCompletedDays / totalDays.value);
  bool get isAllCompleted => totalCompletedDays == totalDays.value;
}

