
enum ChallengeDayStatus { 
  completed, 
  active, 
  locked,
  pass
}

class ChallengeDay {
  final int dayNumber;
  final String title;
  final String description;
  final ChallengeDayStatus status;
  final DateTime? completedDate;

  const ChallengeDay({
    required this.dayNumber,
    required this.title,
    required this.description,
    required this.status,
    this.completedDate,
  });
}