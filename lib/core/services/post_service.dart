import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';
import '../../shared/models/post_model.dart';

class PostService {
  static final _supabase = Supabase.instance.client;

  static Future<List<PostModel>> getCohortFeed(String cohortGroupId) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.postsTable)
          .select('''
            *,
            user:users(id, full_name, username, avatar_url),
            referral:referrals(*)
          ''')
          .eq('cohort_group_id', cohortGroupId)
          .eq('visibility', 'cohort')
          .order('created_at', ascending: false)
          .limit(20);
      return (data as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<PostModel>> getCollegeFeed(String collegeId) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.postsTable)
          .select('''
            *,
            user:users(id, full_name, username, avatar_url),
            referral:referrals(*)
          ''')
          .eq('college_id', collegeId)
          .eq('visibility', 'college_wall')
          .order('created_at', ascending: false)
          .limit(20);
      return (data as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<PostModel>> getGlobalFeed() async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.postsTable)
          .select('''
            *,
            user:users(id, full_name, username, avatar_url),
            referral:referrals(*)
          ''')
          .eq('visibility', 'global')
          .order('created_at', ascending: false)
          .limit(20);
      return (data as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<PostModel>> getTrendingFeed() async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.postsTable)
          .select('''
            *,
            user:users(id, full_name, username, avatar_url),
            referral:referrals(*)
          ''')
          .order('trend_count', ascending: false)
          .limit(20);
      return (data as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<PostModel>> getWallFeed() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final walledUsers = await _supabase
          .from(SupabaseConstants.wallsTable)
          .select('walled_id')
          .eq('waller_id', userId);

      final walledIds = (walledUsers as List)
          .map((e) => e['walled_id'] as String)
          .toList();

      if (walledIds.isEmpty) return [];

      final data = await _supabase
          .from(SupabaseConstants.postsTable)
          .select('''
            *,
            user:users(id, full_name, username, avatar_url),
            referral:referrals(*)
          ''')
          .inFilter('user_id', walledIds)
          .order('created_at', ascending: false)
          .limit(20);

      return (data as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<PostModel?> createPost({
    required String content,
    required String visibility,
    String? collegeId,
    String? cohortGroupId,
    String? openGroupId,
    bool isReferral = false,
    List<String>? mediaUrls,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final postData = {
        'user_id': userId,
        'content': content,
        'visibility': visibility,
        'is_referral': isReferral,
        if (collegeId != null) 'college_id': collegeId,
        if (cohortGroupId != null) 'cohort_group_id': cohortGroupId,
        if (openGroupId != null) 'open_group_id': openGroupId,
        if (mediaUrls != null) 'media_urls': mediaUrls,
        if (isReferral)
          'expires_at': DateTime.now()
              .add(const Duration(days: 30))
              .toIso8601String(),
      };

      final data = await _supabase
          .from(SupabaseConstants.postsTable)
          .insert(postData)
          .select()
          .single();

      return PostModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<void> likePost(String postId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase.from(SupabaseConstants.likesTable).upsert({
        'post_id': postId,
        'user_id': userId,
      });

      await _supabase.rpc('increment_likes', params: {'post_id': postId});
    } catch (e) {
      return;
    }
  }

  static Future<void> unlikePost(String postId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase
          .from(SupabaseConstants.likesTable)
          .delete()
          .eq('post_id', postId)
          .eq('user_id', userId);

      await _supabase.rpc('decrement_likes', params: {'post_id': postId});
    } catch (e) {
      return;
    }
  }

  static Future<void> trendPost(String postId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase.from(SupabaseConstants.trendsTable).upsert({
        'post_id': postId,
        'user_id': userId,
      });

      await _supabase.rpc('increment_trend', params: {'post_id': postId});
    } catch (e) {
      return;
    }
  }

  static Future<void> untrendPost(String postId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase
          .from(SupabaseConstants.trendsTable)
          .delete()
          .eq('post_id', postId)
          .eq('user_id', userId);

      await _supabase.rpc('decrement_trend', params: {'post_id': postId});
    } catch (e) {
      return;
    }
  }

  static Future<bool> isLiked(String postId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final data = await _supabase
          .from(SupabaseConstants.likesTable)
          .select()
          .eq('post_id', postId)
          .eq('user_id', userId)
          .maybeSingle();

      return data != null;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isTrended(String postId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final data = await _supabase
          .from(SupabaseConstants.trendsTable)
          .select()
          .eq('post_id', postId)
          .eq('user_id', userId)
          .maybeSingle();

      return data != null;
    } catch (e) {
      return false;
    }
  }
}