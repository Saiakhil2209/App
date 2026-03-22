import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';
import '../../shared/models/college_model.dart';

class CollegeService {
  static final _supabase = Supabase.instance.client;

  static Future<List<CollegeModel>> searchColleges(String query) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.collegesTable)
          .select()
          .eq('status', 'approved')
          .ilike('name', '%$query%')
          .limit(10);

      return (data as List).map((e) => CollegeModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<CollegeModel?> getCollegeById(String id) async {
    try {
      final data = await _supabase
          .from(SupabaseConstants.collegesTable)
          .select()
          .eq('id', id)
          .maybeSingle();

      if (data == null) return null;
      return CollegeModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<CollegeModel?> submitCollege({
    required String name,
    required String city,
    required String state,
  }) async {
    try {
      final normalized = name
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
          .replaceAll(
              RegExp(r'\b(of|and|the|institute|college|university|&)\b'),
              '')
          .trim();

      final data = await _supabase
          .from(SupabaseConstants.collegesTable)
          .insert({
            'name': name,
            'name_normalized': normalized,
            'city': city,
            'state': state,
            'status': 'pending',
          })
          .select()
          .single();

      return CollegeModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getOrCreateCohortGroup({
    required String collegeId,
    required int passoutYear,
  }) async {
    try {
      final existing = await _supabase
          .from(SupabaseConstants.cohortGroupsTable)
          .select('id')
          .eq('college_id', collegeId)
          .eq('passout_year', passoutYear)
          .maybeSingle();

      if (existing != null) return existing['id'] as String;

      final created = await _supabase
          .from(SupabaseConstants.cohortGroupsTable)
          .insert({
            'college_id': collegeId,
            'passout_year': passoutYear,
          })
          .select('id')
          .single();

      return created['id'] as String;
    } catch (e) {
      return null;
    }
  }
}