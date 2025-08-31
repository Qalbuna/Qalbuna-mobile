class NeedType {
  final int id;
  final String icon;
  final String label;
  final String value;

  const NeedType({
    required this.id,
    required this.icon,
    required this.label,
    required this.value,
  });

  factory NeedType.fromJson(Map<String, dynamic> json) {
    return NeedType(
      id: json['id'],
      icon: json['icon'],
      label: json['label'],
      value: json['value'],
    );
  }
}