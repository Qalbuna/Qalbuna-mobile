import '../../../data/models/step_state.dart';

class ChallengeProgressHelper {
  static StepStated getStepState(
    int dayNumber,
    int currentDay,
    List<int> completedDays,
    List<int> passedDays,
  ) {
    if (completedDays.contains(dayNumber)) {
      return StepStated.completed;
    }

    if (passedDays.contains(dayNumber)) {
      return StepStated.pass;
    }

    if (dayNumber == currentDay + 1 && dayNumber != 5) {
      return StepStated.active;
    }

    return StepStated.inactive;
  }

  static int getCompletedNumber(int dayNumber, List<int> completedDays) {
    final sortedCompleted = List<int>.from(completedDays)..sort();
    return sortedCompleted.indexOf(dayNumber) + 1;
  }

  static String getHeaderTitle(List<int> completedDays, int currentDay) {
    if (completedDays.isEmpty) {
      return 'Kamu belum memulai tantangan';
    }
    final nextDay = currentDay + 1;
    if (nextDay != 5) {
      return 'Hari ke- $nextDay~ Kamu pasti bisa! 💪';
    } else {
      return 'Alhamdulillah tantangan hari ini selesai🌟';
    }
  }

  static String getHeaderSubtitle(List<int> completedDays, int totalDays) {
    return completedDays.isEmpty
        ? 'Mulailah tantangan Qalbuna hari ini'
        : '${completedDays.length} dari $totalDays hari berhasil diselesaikan';
  }
}
