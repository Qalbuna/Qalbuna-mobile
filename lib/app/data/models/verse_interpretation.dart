class VerseInterpretation {
  final String id;
  final String verseId;
  final String tafsirSource;
  final String interpretationText;
  final String? briefInterpretation;

  const VerseInterpretation({
    required this.id,
    required this.verseId,
    required this.tafsirSource,
    required this.interpretationText,
    this.briefInterpretation,
  });

  factory VerseInterpretation.fromJson(Map<String, dynamic> json) {
    return VerseInterpretation(
      id: json['id'] ?? '',
      verseId: json['verse_id'] ?? '',
      tafsirSource: json['tafsir_source'] ?? 'Tafsir Al-Muyassar',
      interpretationText: json['interpretation_text'] ?? '',
      briefInterpretation: json['brief_interpretation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'verse_id': verseId,
      'tafsir_source': tafsirSource,
      'interpretation_text': interpretationText,
      'brief_interpretation': briefInterpretation,
    };
  }
}