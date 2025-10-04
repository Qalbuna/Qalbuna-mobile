class NeedType {
  final int id;
  final String icon;
  final String label;
  final String value;
  final String moodValue;

  const NeedType({
    required this.id,
    required this.icon,
    required this.label,
    required this.value,
    required this.moodValue,
  });

  factory NeedType.fromJson(Map<String, dynamic> json) {
    return NeedType(
      id: json['id'],
      icon: json['icon'],
      label: json['label'],
      value: json['value'],
      moodValue: json['mood_value'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'label': label,
      'value': value,
      'mood_value': moodValue,
    };
  }
}
