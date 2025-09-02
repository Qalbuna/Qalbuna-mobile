// lib/app/data/models/verse.dart - UPDATE FINAL
import 'surah.dart';
import 'verse_interpretation.dart';

class Verse {
  final String id;
  final int surahId;
  final int verseNumber;
  final String arabicText;
  final String translationId;
  final String reciterCode;
  final int? ayahNumber;
  final String? audioUrl; // Untuk caching URL yang sudah di-generate
  final DateTime createdAt;
  final Surah? surah;
  final VerseInterpretation? interpretation;

  const Verse({
    required this.id,
    required this.surahId,
    required this.verseNumber,
    required this.arabicText,
    required this.translationId,
    required this.reciterCode,
    this.ayahNumber,
    this.audioUrl,
    required this.createdAt,
    this.surah,
    this.interpretation,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'] ?? '',
      surahId: json['surah_id'] ?? 0,
      verseNumber: json['verse_number'] ?? 0,
      arabicText: json['arabic_text'] ?? '',
      translationId: json['translation_id'] ?? '',
      reciterCode: json['reciter_code'] ?? 'ar.alafasy',
      ayahNumber: json['ayah_number'],
      audioUrl: json['audio_url'], // Bisa null jika belum di-generate
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      surah: json['surahs'] != null ? Surah.fromJson(json['surahs']) : null,
      interpretation: json['verse_interpretations'] != null && 
                     (json['verse_interpretations'] as List).isNotEmpty
          ? VerseInterpretation.fromJson(json['verse_interpretations'][0])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surah_id': surahId,
      'verse_number': verseNumber,
      'arabic_text': arabicText,
      'translation_id': translationId,
      'reciter_code': reciterCode,
      'ayah_number': ayahNumber,
      'audio_url': audioUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Verse copyWith({
    String? id,
    int? surahId,
    int? verseNumber,
    String? arabicText,
    String? translationId,
    String? reciterCode,
    int? ayahNumber,
    String? audioUrl,
    DateTime? createdAt,
    Surah? surah,
    VerseInterpretation? interpretation,
  }) {
    return Verse(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      verseNumber: verseNumber ?? this.verseNumber,
      arabicText: arabicText ?? this.arabicText,
      translationId: translationId ?? this.translationId,
      reciterCode: reciterCode ?? this.reciterCode,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      audioUrl: audioUrl ?? this.audioUrl,
      createdAt: createdAt ?? this.createdAt,
      surah: surah ?? this.surah,
      interpretation: interpretation ?? this.interpretation,
    );
  }

  String get reference {
    if (surah != null) {
      return 'QS. ${surah!.nameLatin}: $verseNumber';
    }
    return 'QS. $verseNumber';
  }
}