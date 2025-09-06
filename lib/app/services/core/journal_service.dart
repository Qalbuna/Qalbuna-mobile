import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/journal_model.dart';

class JournalService {
  static final _supabase = Supabase.instance.client;

  static Future<List<JournalModel>> getJournals(String userId) async {
    try {
      final response = await _supabase
          .from('journals')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => JournalModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Gagal mengambil data jurnal: $e');
    }
  }

  static Future<JournalModel> addJournal(JournalModel journal) async {
    try {
      final response = await _supabase
          .from('journals')
          .insert(journal.toJson())
          .select()
          .single();

      return JournalModel.fromJson(response);
    } catch (e) {
      throw Exception('Gagal menambah jurnal: $e');
    }
  }

  static Future<JournalModel> updateJournal(JournalModel journal) async {
    try {
      final response = await _supabase
          .from('journals')
          .update(journal.toJson())
          .eq('id', journal.id!)
          .select()
          .single();

      return JournalModel.fromJson(response);
    } catch (e) {
      throw Exception('Gagal mengupdate jurnal: $e');
    }
  }

  static Future<void> deleteJournal(String journalId) async {
    try {
      await _supabase
          .from('journals')
          .delete()
          .eq('id', journalId);
    } catch (e) {
      throw Exception('Gagal menghapus jurnal: $e');
    }
  }

  static Future<void> deleteAllJournals(String userId) async {
    try {
      await _supabase
          .from('journals')
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Gagal menghapus semua jurnal: $e');
    }
  }
}