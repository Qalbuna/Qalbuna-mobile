class MoodType {
  final int id;
  final String emoji;
  final String label;
  final String value;

  const MoodType({
    required this.id,
    required this.emoji,
    required this.label,
    required this.value,
  });

  factory MoodType.fromJson(Map<String, dynamic> json) {
    return MoodType(
      id: json['id'],
      emoji: json['emoji'],
      label: json['label'],
      value: json['value'],
    );
  }
}