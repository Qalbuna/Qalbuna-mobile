class ConnectionItem {
  final String icon;
  final String label;
  final String value;
  final String? description;

  const ConnectionItem({
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

  factory ConnectionItem.fromJson(Map<String, dynamic> json) {
    return ConnectionItem(
      icon: json['icon'] ?? '',
      label: json['label'] ?? '',
      value: json['value'] ?? '',
      description: json['description'],
    );
  }
}