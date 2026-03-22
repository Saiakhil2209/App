import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';
import '../../shared/models/user_model.dart';

class UserService {
  static final _supabase = Supabase.instance.client;

  static Future<UserModel?> getCurrentUser() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final data = await _supabase
          .from(SupabaseConstants.usersTable)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (data == null) return null;
      return UserModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<UserModel?> getUserById(String userId) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.usersTable)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (data == null) return null;
      return UserModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<void> createUser({
    required String id,
    required String fullName,
    required String username,
  }) async {
    await _supabase.from(SupabaseConstants.usersTable).upsert({
      'id': id,
      'full_name': fullName,
      'username': username,
    });
  }

  static Future<void> updateUser(Map<String, dynamic> data) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;
    await _supabase
        .from(SupabaseConstants.usersTable)
        .update(data)
        .eq('id', userId);
  }

  static Future<bool> userExists(String userId) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.usersTable)
          .select('id')
          .eq('id', userId)
          .maybeSingle();
      return data != null;
    } catch (e) {
      return false;
    }
  }

  static Future<List<UserModel>> searchUsers(String query) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.usersTable)
          .select()
          .or('full_name.ilike.%$query%,username.ilike.%$query%')
          .limit(20);
      return (data as List).map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}