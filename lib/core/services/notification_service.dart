import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';

class NotificationService {
  static final _supabase = Supabase.instance.client;

  static Future<List<Map<String, dynamic>>> getNotifications() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final data = await _supabase
          .from(SupabaseConstants.notificationsTable)
          .select('*, actor:users!actor_id(id, full_name, avatar_url)')
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(30);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      return [];
    }
  }

  static Future<void> markAllRead() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase
          .from(SupabaseConstants.notificationsTable)
          .update({'is_read': true}).eq('user_id', userId);
    } catch (e) {
      return;
    }
  }

  static Future<int> getUnreadCount() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return 0;

      final data = await _supabase
          .from(SupabaseConstants.notificationsTable)
          .select()
          .eq('user_id', userId)
          .eq('is_read', false)
          .count();

      return data.count;
    } catch (e) {
      return 0;
    }
  }

  static Future<void> createNotification({
    required String userId,
    required String actorId,
    required String type,
    String? refId,
  }) async {
    try {
      await _supabase.from(SupabaseConstants.notificationsTable).insert({
        'user_id': userId,
        'actor_id': actorId,
        'type': type,
        if (refId != null) 'ref_id': refId,
      });
    } catch (e) {
      return;
    }
  }

  static RealtimeChannel subscribeToNotifications(
      String userId, Function(Map<String, dynamic>) onNew) {
    return _supabase
        .channel('notifications:$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'notifications',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) => onNew(payload.newRecord),
        )
        .subscribe();
  }
}