import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';
import '../../shared/models/user_model.dart';

class WallService {
  static final _supabase = Supabase.instance.client;

  static Future<void> wallUser(String walledId) async {
    try {
      final wallerId = _supabase.auth.currentUser?.id;
      if (wallerId == null) return;

      await _supabase.from(SupabaseConstants.wallsTable).upsert({
        'waller_id': wallerId,
        'walled_id': walledId,
      });
    } catch (e) {
      return;
    }
  }

  static Future<void> unwallUser(String walledId) async {
    try {
      final wallerId = _supabase.auth.currentUser?.id;
      if (wallerId == null) return;

      await _supabase
          .from(SupabaseConstants.wallsTable)
          .delete()
          .eq('waller_id', wallerId)
          .eq('walled_id', walledId);
    } catch (e) {
      return;
    }
  }

  static Future<bool> isWalled(String walledId) async {
    try {
      final wallerId = _supabase.auth.currentUser?.id;
      if (wallerId == null) return false;

      final data = await _supabase
          .from(SupabaseConstants.wallsTable)
          .select()
          .eq('waller_id', wallerId)
          .eq('walled_id', walledId)
          .maybeSingle();

      return data != null;
    } catch (e) {
      return false;
    }
  }

  static Future<List<UserModel>> getWalledByYou() async {
    try {
      final wallerId = _supabase.auth.currentUser?.id;
      if (wallerId == null) return [];

      final data = await _supabase
          .from(SupabaseConstants.wallsTable)
          .select('walled:users!walled_id(*)')
          .eq('waller_id', wallerId);

      return (data as List)
          .map((e) => UserModel.fromJson(e['walled']))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<UserModel>> getWalledYou() async {
    try {
      final walledId = _supabase.auth.currentUser?.id;
      if (walledId == null) return [];

      final data = await _supabase
          .from(SupabaseConstants.wallsTable)
          .select('waller:users!waller_id(*)')
          .eq('walled_id', walledId);

      return (data as List)
          .map((e) => UserModel.fromJson(e['waller']))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<int> getWalledByYouCount() async {
    try {
      final wallerId = _supabase.auth.currentUser?.id;
      if (wallerId == null) return 0;

      final data = await _supabase
          .from(SupabaseConstants.wallsTable)
          .select()
          .eq('waller_id', wallerId)
          .count();

      return data.count;
    } catch (e) {
      return 0;
    }
  }

  static Future<int> getWalledYouCount() async {
    try {
      final walledId = _supabase.auth.currentUser?.id;
      if (walledId == null) return 0;

      final data = await _supabase
          .from(SupabaseConstants.wallsTable)
          .select()
          .eq('walled_id', walledId)
          .count();

      return data.count;
    } catch (e) {
      return 0;
    }
  }
}