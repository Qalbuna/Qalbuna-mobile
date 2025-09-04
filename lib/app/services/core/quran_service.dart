import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import '../../data/models/verse.dart';
import '../auth/auth_services.dart';

class QuranService {
  static final _client = Supabase.instance.client;
  static final _authServices = AuthServices();
  
  static User? get currentUser => _authServices.getCurrentUser();
  static String? get currentUserId => currentUser?.id;

  static String generateEveryAyahUrl(int surahNumber, int verseNumber) {
    final surahPadded = surahNumber.toString().padLeft(3, '0');
    final versePadded = verseNumber.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/Alafasy_128kbps/$surahPadded$versePadded.mp3';
  }

  static Future<List<Verse>> getVersesByEmotion(
    String emotionValue, {
    int limit = 5,
    int offset = 0,
  }) async {
    try {
      final emotionResponse = await _client
          .from('verse_emotions')
          .select('verse_id, relevance_score, tags')
          .eq('emotion_value', emotionValue)
          .order('relevance_score', ascending: false)
          .range(offset, offset + limit - 1);

      if (emotionResponse.isEmpty) return [];

      List<Verse> verses = [];

      for (final emotion in emotionResponse) {
        final verseResponse = await _client
            .from('verses')
            .select('''
              id, surah_id, verse_number, arabic_text, translation_id,
              actual_surah_number, actual_verse_number, reciter_code, created_at,
              surahs!inner(
                id, number, name_arabic, name_latin, translation, 
                revelation_place, total_verses
              ),
              verse_interpretations(
                id, verse_id, tafsir_source, interpretation_text, 
                brief_interpretation
              )
            ''')
            .eq('id', emotion['verse_id'])
            .single();

        final verse = Verse.fromJson(verseResponse);
        final audioUrl = generateEveryAyahUrl(
          verse.actualSurahNumber,
          verse.actualVerseNumber,
        );
        final verseWithAudio = verse.copyWith(audioUrl: audioUrl);
        verses.add(verseWithAudio);
      }

      return verses;
    } catch (e) {
      throw Exception('Error in getVersesByEmotion: $e');
    }
  }

  static Future<Verse?> getRandomVerseByEmotion(String emotionValue) async {
    try {
      final verses = await getVersesByEmotion(emotionValue, limit: 10);
      if (verses.isEmpty) return null;

      final randomIndex = DateTime.now().millisecondsSinceEpoch % verses.length;
      return verses[randomIndex];
    } catch (e) {
      throw Exception('Error getting random verse: $e');
    }
  }

  static Future<String?> getAudioUrl(String verseId, {int bitrate = 128}) async {
    try {
      final response = await _client
          .from('verses')
          .select('actual_surah_number, actual_verse_number')
          .eq('id', verseId)
          .single();
      
      final surahNumber = response['actual_surah_number'] as int;
      final verseNumber = response['actual_verse_number'] as int;
      
      return generateEveryAyahUrl(surahNumber, verseNumber);
    } catch (e) {
      throw Exception('Error generating audio URL: $e');
    }
  }

  static Future<bool> checkAudioAvailability(String audioUrl) async {
    try {
      final response = await http.head(Uri.parse(audioUrl));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<void> recordVerseReading({
    required String verseId,
    String? moodEntryId,
  }) async {
    try {
      if (currentUserId == null) return;

      await _client.from('user_verse_readings').upsert({
        'user_id': currentUserId,
        'verse_id': verseId,
        'mood_entry_id': moodEntryId,
        'read_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Error recording verse reading: $e');
    }
  }

  static Future<void> toggleVerseFavorite(String verseId) async {
    try {
      if (currentUserId == null) return;

      final existing = await _client
          .from('user_verse_readings')
          .select('id, is_favorited')
          .eq('user_id', currentUserId!)
          .eq('verse_id', verseId)
          .maybeSingle();

      if (existing != null) {
        await _client
            .from('user_verse_readings')
            .update({'is_favorited': !(existing['is_favorited'] ?? false)})
            .eq('id', existing['id']);
      } else {
        await _client.from('user_verse_readings').insert({
          'user_id': currentUserId,
          'verse_id': verseId,
          'is_favorited': true,
          'read_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Gagal mengubah status favorite: $e');
    }
  }

  static Future<bool> isVerseFavorited(String verseId) async {
    try {
      if (currentUserId == null) return false;

      final response = await _client
          .from('user_verse_readings')
          .select('is_favorited')
          .eq('user_id', currentUserId!)
          .eq('verse_id', verseId)
          .eq('is_favorited', true)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  static Future<Verse?> getVerseForMoodEntry(String moodEntryId) async {
    try {
      final moodEntry = await _client
          .from('mood_entries')
          .select('id, mood_types!inner(value)')
          .eq('id', moodEntryId)
          .single();

      final emotionValue = moodEntry['mood_types']['value'] as String;
      final verse = await getRandomVerseByEmotion(emotionValue);
      
      if (verse != null) {
        await recordVerseReading(
          verseId: verse.id,
          moodEntryId: moodEntryId,
        );
      }
      
      return verse;
    } catch (e) {
      throw Exception('Error getting verse for mood entry: $e');
    }
  }
}