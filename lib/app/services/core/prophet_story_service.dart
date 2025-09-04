import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/prophet_story.dart';
import '../auth/auth_services.dart';

class ProphetStoryService {
  static final _client = Supabase.instance.client;
  static final _authServices = AuthServices();

  static User? get currentUser => _authServices.getCurrentUser();
  static String? get currentUserId => currentUser?.id;
  static bool get isSignedIn => _authServices.isSignedIn();

  static Future<ProphetStory?> getStoryByEmotion(String emotionValue) async {
    try {
      final response = await _client
          .rpc('get_video_by_emotion', params: {'emotion': emotionValue})
          .select()
          .maybeSingle();

      if (response == null) return null;

      return ProphetStory.fromJson(response);
    } catch (e) {
      throw Exception('Error getting story by emotion: $e');
    }
  }

  static Future<void> recordVideoView({
    required String prophetStoryId,
    String? moodEntryId,
    bool isCompleted = false,
    int? watchDuration,
  }) async {
    try {
      if (!isSignedIn) return;

      await _client.rpc(
        'record_video_view',
        params: {
          'p_user_id': currentUserId,
          'p_prophet_story_id': prophetStoryId,
          'p_mood_entry_id': moodEntryId,
        },
      );
      if (isCompleted && watchDuration != null) {
        final viewResponse = await _client
            .from('user_video_views')
            .select('id')
            .eq('user_id', currentUserId!)
            .eq('prophet_story_id', prophetStoryId)
            .order('viewed_at', ascending: false)
            .limit(1)
            .single();

        await _client
            .from('user_video_views')
            .update({'is_completed': true, 'watch_duration': watchDuration})
            .eq('id', viewResponse['id']);
      }
    } catch (e) {
      throw Exception('Error recording video view: $e');
    }
  }

  static Future<List<ProphetStory>> getAllStories() async {
    try {
      final response = await _client
          .from('prophet_stories')
          .select()
          .eq('is_active', true)
          .order('title');

      return (response as List)
          .map((json) => ProphetStory.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error getting all stories: $e');
    }
  }

  static Future<List<ProphetStory>> getRecentlyViewedStories({
    int limit = 5,
  }) async {
    try {
      if (!isSignedIn) return [];

      final response = await _client
          .from('user_video_views')
          .select('prophet_story_id, viewed_at, prophet_stories(*)')
          .eq('user_id', currentUserId!)
          .order('viewed_at', ascending: false)
          .limit(limit);

      return (response as List)
          .map((json) => ProphetStory.fromJson(json['prophet_stories']))
          .toList();
    } catch (e) {
      throw Exception('Error getting recently viewed stories: $e');
    }
  }

  static Future<List<ProphetStory>> getRecommendedStories({
    int limit = 3,
  }) async {
    try {
      if (!isSignedIn) {
        final response = await _client
            .from('prophet_stories')
            .select()
            .eq('is_active', true)
            .limit(limit);

        return (response as List)
            .map((json) => ProphetStory.fromJson(json))
            .toList();
      }

      final moodStats = await _client
          .from('mood_entries')
          .select('mood_types(value)')
          .eq('user_id', currentUserId!)
          .order('created_at', ascending: false)
          .limit(10);

      final emotionValues = (moodStats as List)
          .map((entry) => entry['mood_types']['value'] as String)
          .toList();

      if (emotionValues.isEmpty) {
        final response = await _client
            .from('prophet_stories')
            .select()
            .eq('is_active', true)
            .limit(limit);

        return (response as List)
            .map((json) => ProphetStory.fromJson(json))
            .toList();
      }
      final response = await _client
          .from('emotion_videos')
          .select('prophet_stories(*)')
          .inFilter('emotion_value', emotionValues)
          .eq('is_primary', true)
          .limit(limit);

      return (response as List)
          .map((json) => ProphetStory.fromJson(json['prophet_stories']))
          .toList();
    } catch (e) {
      throw Exception('Error getting recommended stories: $e');
    }
  }
}
