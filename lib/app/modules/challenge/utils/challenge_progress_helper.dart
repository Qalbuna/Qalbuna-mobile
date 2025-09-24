import '../../../data/models/step_state.dart';

class ChallengeProgressHelper {
  static StepStated getStepState(
    int dayNumber, 
    int currentDay, 
    List<int> completedDays, 
    List<int> passedDays
  ) {
    if (completedDays.contains(dayNumber)) {
      return StepStated.completed;
    }
    
    if (passedDays.contains(dayNumber)) {
      return StepStated.pass;
    }
    
    if (dayNumber == currentDay + 1) {
      return StepStated.active;
    }

    return StepStated.inactive;
  }

  static int getCompletedNumber(int dayNumber, List<int> completedDays) {
    final sortedCompleted = List<int>.from(completedDays)..sort();
    return sortedCompleted.indexOf(dayNumber) + 1;
  }

  static String getHeaderTitle(List<int> completedDays) {
    return completedDays.isEmpty 
        ? 'Kamu belum memulai tantangan'
        : 'Progress Tantangan Qalbuna';
  }

  
}