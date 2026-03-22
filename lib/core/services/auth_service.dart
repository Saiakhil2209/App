import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final _supabase = Supabase.instance.client;

  static Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.intouch://login-callback',
    );
  }

  static Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  static User? get currentUser => _supabase.auth.currentUser;
  static Session? get currentSession => _supabase.auth.currentSession;
  static bool get isLoggedIn => currentSession != null;

  static Stream<AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;
}