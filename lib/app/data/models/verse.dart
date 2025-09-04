import 'surah.dart';
import 'verse_interpretation.dart';

class Verse {
  final String id;
  final int surahId;
  final int verseNumber;
  final String arabicText;
  final String translationId;
  final int actualSurahNumber;
  final int actualVerseNumber;
  final String reciterCode;
  final String? audioUrl; 
  final DateTime createdAt;
  final Surah? surah;
  final VerseInterpretation? interpretation;

  const Verse({
    required this.id,
    required this.surahId,
    required this.verseNumber,
    required this.arabicText,
    required this.translationId,
    required this.actualSurahNumber,
    required this.actualVerseNumber,
    required this.reciterCode,
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
      actualSurahNumber: json['actual_surah_number'] ?? 0,
      actualVerseNumber: json['actual_verse_number'] ?? 0,
      reciterCode: json['reciter_code'] ?? 'ar.alafasy',
      audioUrl: json['audio_url'], 
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
      'actual_surah_number': actualSurahNumber,
      'actual_verse_number': actualVerseNumber,
      'reciter_code': reciterCode,
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
    int? actualSurahNumber,
    int? actualVerseNumber,
    String? reciterCode,
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
      actualSurahNumber: actualSurahNumber ?? this.actualSurahNumber,
      actualVerseNumber: actualVerseNumber ?? this.actualVerseNumber,
      reciterCode: reciterCode ?? this.reciterCode,
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
    return 'QS. $actualSurahNumber: $verseNumber';
  }

  int get ayahNumber => actualVerseNumber;
  int get surahNumber => actualSurahNumber;
}