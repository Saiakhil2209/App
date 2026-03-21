import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/onboarding/screens/college_screen.dart';
import '../../features/onboarding/screens/education_screen.dart';
import '../../features/onboarding/screens/profile_setup_screen.dart';
import '../../features/onboarding/screens/pending_vouch_screen.dart';
import '../../features/home/screens/home_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/onboarding/college':
        return MaterialPageRoute(builder: (_) => const CollegeScreen());
      case '/onboarding/education':
        return MaterialPageRoute(builder: (_) => const EducationScreen());
      case '/onboarding/profile':
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());
      case '/onboarding/pending':
        return MaterialPageRoute(builder: (_) => const PendingVouchScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    }
  }

  // Check if user is logged in and where to send them
  static String getInitialRoute() {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) return '/';
    return '/home';
  }
}