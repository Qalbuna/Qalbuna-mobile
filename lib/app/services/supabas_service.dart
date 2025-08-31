import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/modules/connection_type.dart';
import '../data/modules/mood_type.dart';
import '../data/modules/need_type.dart';
import 'auth_services.dart';

class SupabaseService {
  static final _client = Supabase.instance.client;
  static final _authServices = AuthServices();
  
  // Get current user
  static User? get currentUser => _authServices.getCurrentUser();
  static String? get currentUserId => currentUser?.id;

  // ============== MASTER DATA ==============
  
  static Future<List<MoodType>> getMoodTypes() async {
    try {
      final response = await _client
          .from('mood_types')
          .select()
          .order('id');
      
      return (response as List)
          .map((json) => MoodType.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch mood types: $e');
    }
  }

  static Future<List<NeedType>> getNeedTypes() async {
    try {
      final response = await _client
          .from('need_types')
          .select()
          .order('id');
      
      return (response as List)
          .map((json) => NeedType.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch need types: $e');
    }
  }

  static Future<List<ConnectionType>> getConnectionTypes() async {
    try {
      final response = await _client
          .from('connection_types')
          .select()
          .order('id');
      
      return (response as List)
          .map((json) => ConnectionType.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch connection types: $e');
    }
  }

  // ============== MOOD ENTRIES ==============

  static Future<String> createMoodEntry({
    required String moodValue,
    required List<String> needValues,
    required String connectionValue,
    String? notes,
  }) async {
    try {
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      // Get mood type ID
      final moodTypeResponse = await _client
          .from('mood_types')
          .select('id')
          .eq('value', moodValue)
          .single();
      
      final moodTypeId = moodTypeResponse['id'];

      // Create mood entry
      final now = DateTime.now();
     final timeString = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      
      final entryResponse = await _client
          .from('mood_entries')
          .insert({
            'user_id': currentUserId,
            'mood_type_id': moodTypeId,
            'entry_date': now.toIso8601String().split('T')[0],
            'entry_time': timeString,
            'notes': notes,
          })
          .select('id')
          .single();

      final entryId = entryResponse['id'];

      // Add needs
      if (needValues.isNotEmpty) {
        final needTypesResponse = await _client
            .from('need_types')
            .select('id, value')
            .inFilter('value', needValues);

        final needInserts = needTypesResponse.map((needType) => {
              'mood_entry_id': entryId,
              'need_type_id': needType['id'],
            }).toList();

        await _client.from('mood_entry_needs').insert(needInserts);
      }

      // Add connection
      final connectionTypeResponse = await _client
          .from('connection_types')
          .select('id')
          .eq('value', connectionValue)
          .single();

      await _client.from('mood_entry_connections').insert({
        'mood_entry_id': entryId,
        'connection_type_id': connectionTypeResponse['id'],
      });

      return entryId;
    } catch (e) {
      throw Exception('Failed to create mood entry: $e');
    }
  }

  static Future<Map<String, dynamic>?> getTodayMoodEntry() async {
    try {
      if (currentUserId == null) return null;

      final today = DateTime.now().toIso8601String().split('T')[0];
      
      // Get mood entry with mood type
      final entryResponse = await _client
          .from('mood_entries')
          .select('''
            id, entry_date, entry_time, notes, created_at,
            mood_types(emoji, label, value)
          ''')
          .eq('user_id', currentUserId!)
          .eq('entry_date', today)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (entryResponse == null) return null;

      // Get needs
      final needsResponse = await _client
          .from('mood_entry_needs')
          .select('need_types(icon, label, value)')
          .eq('mood_entry_id', entryResponse['id']);

      // Get connection
      final connectionResponse = await _client
          .from('mood_entry_connections')
          .select('connection_types(icon, label, value)')
          .eq('mood_entry_id', entryResponse['id'])
          .maybeSingle();

      return {
        'entry': entryResponse,
        'needs': needsResponse,
        'connection': connectionResponse,
      };
    } catch (e) {
      throw Exception('Failed to get today mood entry: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getMoodEntriesByDate(DateTime date) async {
    try {
      if (currentUserId == null) return [];

      final dateString = date.toIso8601String().split('T')[0];
      
      final entriesResponse = await _client
          .from('mood_entries')
          .select('''
            id, entry_date, entry_time, notes, created_at,
            mood_types(emoji, label, value)
          ''')
          .eq('user_id', currentUserId!)
          .eq('entry_date', dateString)
          .order('created_at', ascending: false);

      List<Map<String, dynamic>> results = [];

      for (var entry in entriesResponse) {
        // Get needs for this entry
        final needsResponse = await _client
            .from('mood_entry_needs')
            .select('need_types(icon, label, value)')
            .eq('mood_entry_id', entry['id']);

        // Get connection for this entry
        final connectionResponse = await _client
            .from('mood_entry_connections')
            .select('connection_types(icon, label, value)')
            .eq('mood_entry_id', entry['id'])
            .maybeSingle();

        results.add({
          'entry': entry,
          'needs': needsResponse,
          'connection': connectionResponse,
        });
      }

      return results;
    } catch (e) {
      throw Exception('Failed to get mood entries by date: $e');
    }
  }

  static Future<Map<String, dynamic>> getMoodStatistics({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      if (currentUserId == null) return {};

      final startDateString = startDate.toIso8601String().split('T')[0];
      final endDateString = endDate.toIso8601String().split('T')[0];

      final response = await _client
          .from('mood_entries')
          .select('''
            mood_types(label, value, emoji)
          ''')
          .eq('user_id', currentUserId!)
          .gte('entry_date', startDateString)
          .lte('entry_date', endDateString);

      // Count mood frequencies
      Map<String, int> moodCounts = {};
      for (var entry in response) {
        final moodLabel = entry['mood_types']['label'] as String;
        moodCounts[moodLabel] = (moodCounts[moodLabel] ?? 0) + 1;
      }

      return {
        'total_entries': response.length,
        'mood_counts': moodCounts,
        'date_range': {
          'start': startDateString,
          'end': endDateString,
        }
      };
    } catch (e) {
      throw Exception('Failed to get mood statistics: $e');
    }
  }
  
  static bool get isSignedIn => _authServices.isSignedIn();
  static Stream<AuthState> get authStateChanges => _authServices.authStateChanges;
}