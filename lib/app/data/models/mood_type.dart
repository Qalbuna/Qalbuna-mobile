class MoodType {
  final int id;
  final String emoji;
  final String label;
  final String value;
  final String? description;

  const MoodType({
    required this.id,
    required this.emoji,
    required this.label,
    required this.value,
    this.description,
  });

  factory MoodType.fromJson(Map<String, dynamic> json) {
    return MoodType(
      id: json['id'],
      emoji: json['emoji'],
      label: json['label'],
      value: json['value'],
      description: json['description'],
    );
  }
}