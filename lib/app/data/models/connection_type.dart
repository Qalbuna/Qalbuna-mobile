class ConnectionType {
  final int id;
  final String icon;
  final String label;
  final String value;

  const ConnectionType({
    required this.id,
    required this.icon,
    required this.label,
    required this.value,
  });

  factory ConnectionType.fromJson(Map<String, dynamic> json) {
    return ConnectionType(
      id: json['id'],
      icon: json['icon'],
      label: json['label'],
      value: json['value'],
    );
  }
}