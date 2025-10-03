enum ChallengeDayStatus { completed, active, locked, pass }

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
  ChallengeDay copyWith({
    int? dayNumber,
    String? title,
    String? description,
    ChallengeDayStatus? status,
    DateTime? completedDate,
  }) {
    return ChallengeDay(
      dayNumber: dayNumber ?? this.dayNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      completedDate: completedDate ?? this.completedDate,
    );
  }
}
