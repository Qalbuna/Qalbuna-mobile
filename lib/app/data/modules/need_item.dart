class NeedItem {
  final String icon;
  final String label;
  final String value;
  final String? description;

  const NeedItem({
    required this.icon,
    required this.label,
    required this.value,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'label': label,
      'value': value,
      'description': description,
    };
  }

  factory NeedItem.fromJson(Map<String, dynamic> json) {
    return NeedItem(
      icon: json['icon'] ?? '',
      label: json['label'] ?? '',
      value: json['value'] ?? '',
      description: json['description'],
    );
  }
}