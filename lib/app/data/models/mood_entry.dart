import 'package:flutter/material.dart';

class MoodEntry {
  final String id;
  final String userId;
  final int moodTypeId;
  final DateTime entryDate;
  final TimeOfDay? entryTime;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MoodEntry({
    required this.id,
    required this.userId,
    required this.moodTypeId,
    required this.entryDate,
    this.entryTime,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    String? timeString;
    if (entryTime != null) {
      timeString = '${entryTime!.hour.toString().padLeft(2, '0')}:${entryTime!.minute.toString().padLeft(2, '0')}';
    }
    
    return {
      'id': id,
      'user_id': userId,
      'mood_type_id': moodTypeId,
      'entry_date': entryDate.toIso8601String().split('T')[0],
      'entry_time': timeString,
      'notes': notes,
    };
  }

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      moodTypeId: json['mood_type_id'] ?? 0,
      entryDate: DateTime.parse(json['entry_date']),
      entryTime: json['entry_time'] != null 
        ? TimeOfDay(
            hour: int.parse(json['entry_time'].split(':')[0]),
            minute: int.parse(json['entry_time'].split(':')[1]),
          )
        : null,
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}