import 'package:get/get.dart';
import '../../../data/models/challenge_day_status.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';

class ChallengeController extends GetxController {
  final RxList<ChallengeDay> challengeDays = <ChallengeDay>[].obs;
  final RxInt currentDay = 2.obs;
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
        description:
            'Baca 1 ayat dengan tenang, lalu tulis di jurnal kenapa kamu merasa sedih hari ini',
        status: ChallengeDayStatus.completed,
        completedDate: DateTime(2025, 7, 7),
      ),
      ChallengeDay(
        dayNumber: 2,
        title: 'Hari 2',
        description: 'Yuk baca tafsir ketenangan hari ini, dan tuliskan refleksimu di jurnal',
        status: ChallengeDayStatus.pass,
      ),
      ChallengeDay(
        dayNumber: 3,
        title: 'Hari 3',
        description: 'Mari baca kisah inspiratif hari ini, lalu tulis bagaimana kamu mengaplikasikannya hari ini',
        status: ChallengeDayStatus.completed,
      ),
      ChallengeDay(
        dayNumber: 4,
        title: 'Hari 4',
        description:
            'ceritakan di jurnal kenapa kamu merasa cemas hari ini, ',
        status: ChallengeDayStatus.active,
      ),
      ChallengeDay(
        dayNumber: 5,
        title: 'Hari 5',
        description:
            'Tantangan belum terbuka. Selesaikan setiap hari satu per satu, biar prosesnya makin bermakna.',
        status: ChallengeDayStatus.locked,
      ),
      ChallengeDay(
        dayNumber: 6,
        title: 'Hari 6',
        description:
            'Tantangan belum terbuka. Selesaikan setiap hari satu per satu, biar prosesnya makin bermakna.',
        status: ChallengeDayStatus.locked,
      ),
      ChallengeDay(
        dayNumber: 7,
        title: 'Hari 7',
        description:
            'Tantangan belum terbuka. Selesaikan setiap hari satu per satu, biar prosesnya makin bermakna.',
        status: ChallengeDayStatus.locked,
      ),
    ];

    completedDays.value = [1, 3];
    passedDays.value = [2];
    currentDay.value = 3;
  }

  void startChallenge(ChallengeDay day, {DateTime? completedDate}) {
    if (day.status == ChallengeDayStatus.active) {
      final bottomNavController = Get.find<BottomNavigationController>();
      bottomNavController.setIndex(1);
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
      if (dayNumber != 4) {
        _unlockNextDay(dayNumber);
        challengeDays.refresh();
        completedDays.refresh();
        update();
      }
    }
  }

  void _unlockNextDay(int completedDayNumber) {
    final nextDayNumber = completedDayNumber + 1;
    final nextDayIndex = challengeDays.indexWhere(
      (day) => day.dayNumber == nextDayNumber,
    );

    if (nextDayIndex != -1 &&
        challengeDays[nextDayIndex].status == ChallengeDayStatus.locked) {
      challengeDays[nextDayIndex] = ChallengeDay(
        dayNumber: challengeDays[nextDayIndex].dayNumber,
        title: challengeDays[nextDayIndex].title,
        description: challengeDays[nextDayIndex].description,
        status: ChallengeDayStatus.active,
      );

      currentDay.value = nextDayNumber - 1;
    }
  }

  void viewPassedChallenge(ChallengeDay day) {
    Get.snackbar(
      'Tantangan Dilewati',
      'Hari ${day.dayNumber} telah dilewati. Anda bisa mencoba lagi di tantangan selanjutnya.',
    );
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
  int get totalPassedDays => passedDays.length;
  double get progressPercentage => (totalCompletedDays / totalDays.value);
  bool get isAllCompleted => totalCompletedDays == totalDays.value;
}
