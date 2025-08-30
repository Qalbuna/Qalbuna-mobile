class MoodItem {
  final String emoji;
  final String label;
  final String value;
  final String? description;

  const MoodItem({
    required this.emoji,
    required this.label,
    required this.value,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'emoji': emoji,
      'label': label,
      'value': value,
      'description': description,
    };
  }

  factory MoodItem.fromJson(Map<String, dynamic> json) {
    return MoodItem(
      emoji: json['emoji'] ?? '',
      label: json['label'] ?? '',
      value: json['value'] ?? '',
      description: json['description'],
    );
  }
}
