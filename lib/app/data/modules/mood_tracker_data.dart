class MoodTrackerData {
  final String mood;
  final List<String> needs;
  final String spiritualConnection;
  final DateTime timestamp;
  final String? notes;

  const MoodTrackerData({
    required this.mood,
    required this.needs,
    required this.spiritualConnection,
    required this.timestamp,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'needs': needs,
      'spiritual_connection': spiritualConnection,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }

  factory MoodTrackerData.fromJson(Map<String, dynamic> json) {
    return MoodTrackerData(
      mood: json['mood'] ?? '',
      needs: List<String>.from(json['needs'] ?? []),
      spiritualConnection: json['spiritual_connection'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      notes: json['notes'],
    );
  }

  // Copy with method for updates
  MoodTrackerData copyWith({
    String? mood,
    List<String>? needs,
    String? spiritualConnection,
    DateTime? timestamp,
    String? notes,
  }) {
    return MoodTrackerData(
      mood: mood ?? this.mood,
      needs: needs ?? this.needs,
      spiritualConnection: spiritualConnection ?? this.spiritualConnection,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
    );
  }
}
