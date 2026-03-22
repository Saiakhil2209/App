import 'package:flutter/material.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/onboarding/screens/college_screen.dart';
import '../../features/onboarding/screens/education_screen.dart';
import '../../features/onboarding/screens/profile_setup_screen.dart';
import '../../features/onboarding/screens/pending_vouch_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/post/screens/create_post_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../core/services/auth_service.dart';

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
        return MaterialPageRoute(
            builder: (_) => const ProfileSetupScreen());
      case '/onboarding/pending':
        return MaterialPageRoute(
            builder: (_) => const PendingVouchScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/post/create':
        return MaterialPageRoute(
            builder: (_) => const CreatePostScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/notifications':
        return MaterialPageRoute(
            builder: (_) => const NotificationsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    }
  }

  static String getInitialRoute() {
    if (AuthService.isLoggedIn) return '/home';
    return '/';
  }
}