// lib/app/services/quran_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import '../../data/models/verse.dart';
import '../auth/auth_services.dart';

class QuranService {
  static final _client = Supabase.instance.client;
  static final _authServices = AuthServices();
  
  static User? get currentUser => _authServices.getCurrentUser();
  static String? get currentUserId => currentUser?.id;

  // ============== MENDAPATKAN AYAT BERDASARKAN EMOSI ==============
  
  /// Mendapatkan ayat berdasarkan emosi dari mood_types.value existing
  static Future<List<Verse>> getVersesByEmotion(
    String emotionValue, {
    int limit = 5,
    int offset = 0,
  }) async {
    try {
      final response = await _client
          .from('verse_emotions')
          .select('''
            verses!inner(
              id, surah_id, verse_number, arabic_text, translation_id, 
              reciter_code, ayah_number, created_at,
              surahs!inner(
                id, number, name_arabic, name_latin, translation, 
                revelation_place, total_verses
              ),
              verse_interpretations(
                id, verse_id, tafsir_source, interpretation_text, 
                brief_interpretation
              )
            ),
            relevance_score, tags
          ''')
          .eq('emotion_value', emotionValue)
          .order('relevance_score', ascending: false)
          .range(offset, offset + limit - 1);

      return response.map<Verse>((item) {
        final verseData = item['verses'];
        return Verse.fromJson(verseData);
      }).toList();
    } catch (e) {
      throw Exception('Gagal memuat ayat untuk emosi $emotionValue: $e');
    }
  }

  /// Mendapatkan satu ayat acak berdasarkan emosi untuk home widget
  static Future<Verse?> getRandomVerseByEmotion(String emotionValue) async {
    try {
      final verses = await getVersesByEmotion(emotionValue, limit: 10);
      if (verses.isEmpty) return null;

      final randomIndex = DateTime.now().millisecondsSinceEpoch % verses.length;
      return verses[randomIndex];
    } catch (e) {
      print('Error getting random verse: $e');
      return null;
    }
  }

  // ============== AUDIO MANAGEMENT ==============
  
  /// Generate URL audio menggunakan function database
  static Future<String?> getAudioUrl(String verseId, {int bitrate = 128}) async {
    try {
      final response = await _client
          .rpc('get_audio_url', params: {
            'p_ayah_number': await _getAyahNumber(verseId),
            'p_reciter_code': await _getReciterCode(verseId),
            'p_bitrate': bitrate,
          });
      
      return response as String?;
    } catch (e) {
      print('Error generating audio URL: $e');
      return null;
    }
  }

  /// Helper untuk mendapatkan ayah number
  static Future<int?> _getAyahNumber(String verseId) async {
    try {
      final response = await _client
          .from('verses')
          .select('ayah_number')
          .eq('id', verseId)
          .single();
      
      return response['ayah_number'] as int?;
    } catch (e) {
      return null;
    }
  }

  /// Helper untuk mendapatkan reciter code
  static Future<String> _getReciterCode(String verseId) async {
    try {
      final response = await _client
          .from('verses')
          .select('reciter_code')
          .eq('id', verseId)
          .single();
      
      return response['reciter_code'] ?? 'ar.alafasy';
    } catch (e) {
      return 'ar.alafasy';
    }
  }

  /// Cek ketersediaan audio
  static Future<bool> checkAudioAvailability(String audioUrl) async {
    try {
      final response = await http.head(Uri.parse(audioUrl));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // ============== TRACKING USER VERSE READINGS ==============
  
  /// Catat bacaan ayat user dengan referensi ke mood_entries
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
      print('Error recording verse reading: $e');
    }
  }

  /// Toggle favorite ayat
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
            .update({'is_favorited': !existing['is_favorited']})
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

  /// Cek apakah ayat sudah difavorite
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

  // ============== INTEGRATION HELPER ==============
  
  /// Ambil ayat berdasarkan mood entry yang sudah ada
  static Future<Verse?> getVerseForMoodEntry(String moodEntryId) async {
    try {
      // Ambil mood type dari mood entry
      final moodEntry = await _client
          .from('mood_entries')
          .select('''
            id,
            mood_types!inner(value)
          ''')
          .eq('id', moodEntryId)
          .single();

      final emotionValue = moodEntry['mood_types']['value'] as String;
      
      // Ambil ayat random untuk emosi ini
      final verse = await getRandomVerseByEmotion(emotionValue);
      
      if (verse != null) {
        // Catat bacaan ini
        await recordVerseReading(
          verseId: verse.id,
          moodEntryId: moodEntryId,
        );
      }
      
      return verse;
    } catch (e) {
      print('Error getting verse for mood entry: $e');
      return null;
    }
  }
}