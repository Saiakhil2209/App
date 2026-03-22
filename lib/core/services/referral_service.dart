import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';
import '../../shared/models/referral_model.dart';

class ReferralService {
  static final _supabase = Supabase.instance.client;

  static Future<ReferralModel?> createReferral({
    required String postId,
    required String company,
    String? roleTitle,
    String? location,
    String? experienceLevel,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final data = await _supabase
          .from(SupabaseConstants.referralsTable)
          .insert({
            'post_id': postId,
            'user_id': userId,
            'company': company,
            'company_normalized': company.toLowerCase().trim(),
            'role_title': roleTitle,
            'location': location,
            'experience_level': experienceLevel,
            'status': 'open',
          })
          .select()
          .single();

      return ReferralModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> applyToReferral({
    required String referralId,
    required String linkedinUrl,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      await _supabase
          .from(SupabaseConstants.referralApplicationsTable)
          .upsert({
        'referral_id': referralId,
        'applicant_id': userId,
        'linkedin_url': linkedinUrl,
        'status': 'pending',
      });

      await _supabase.rpc('increment_applicants',
          params: {'referral_id': referralId});

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasApplied(String referralId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final data = await _supabase
          .from(SupabaseConstants.referralApplicationsTable)
          .select()
          .eq('referral_id', referralId)
          .eq('applicant_id', userId)
          .maybeSingle();

      return data != null;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getApplicants(
      String referralId) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.referralApplicationsTable)
          .select('*, applicant:users(*)')
          .eq('referral_id', referralId)
          .order('applied_at', ascending: false);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      return [];
    }
  }

  static Future<void> updateApplicationStatus({
    required String applicationId,
    required String status,
  }) async {
    try {
      await _supabase
          .from(SupabaseConstants.referralApplicationsTable)
          .update({'status': status}).eq('id', applicationId);
    } catch (e) {
      return;
    }
  }
}