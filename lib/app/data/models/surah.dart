class Surah {
  final int id;
  final int number;
  final String nameArabic;
  final String nameLatin;
  final String translation;
  final String revelationPlace;
  final int totalVerses;

  const Surah({
    required this.id,
    required this.number,
    required this.nameArabic,
    required this.nameLatin,
    required this.translation,
    required this.revelationPlace,
    required this.totalVerses,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'] ?? 0,
      number: json['number'] ?? 0,
      nameArabic: json['name_arabic'] ?? '',
      nameLatin: json['name_latin'] ?? '',
      translation: json['translation'] ?? '',
      revelationPlace: json['revelation_place'] ?? '',
      totalVerses: json['total_verses'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'name_arabic': nameArabic,
      'name_latin': nameLatin,
      'translation': translation,
      'revelation_place': revelationPlace,
      'total_verses': totalVerses,
    };
  }
}