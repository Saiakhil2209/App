import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/post_card.dart';
import '../../../shared/models/post_model.dart';

class FeedScreen extends StatelessWidget {
  final String spaceId;
  final String spaceType;

  const FeedScreen({
    super.key,
    required this.spaceId,
    required this.spaceType,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy posts for now — we'll connect to Supabase next
    final dummyPosts = [
      PostModel(
        id: '1',
        userId: 'u1',
        content:
            'Need a referral at Amazon SDE-1. 7.8 CGPA, 2 internships done. Anyone from our batch or alumni who can help?',
        isReferral: true,
        likesCount: 24,
        commentsCount: 8,
        trendCount: 12,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        user: {'full_name': 'Rahul Kumar', 'major': 'CSE'},
        referral: {
          'id': 'r1',
          'post_id': '1',
          'user_id': 'u1',
          'company': 'Amazon',
          'role_title': 'SDE-1',
          'location': 'Hyderabad',
          'status': 'open',
          'applicants_count': 12,
        },
      ),
      PostModel(
        id: '2',
        userId: 'u2',
        content:
            'Just cleared TCS NQT! Used GeeksForGeeks aptitude + IndiaBix verbal. Daily mocks for 2 weeks. Anyone else appearing this month?',
        isReferral: false,
        likesCount: 47,
        commentsCount: 19,
        trendCount: 31,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        user: {'full_name': 'Priya Mehta', 'major': 'ECE'},
      ),
      PostModel(
        id: '3',
        userId: 'u3',
        content:
            'Can refer 2 people for Google SDE-2 Hyderabad. 3+ years exp preferred. Apply below with your LinkedIn.',
        isReferral: true,
        likesCount: 91,
        commentsCount: 14,
        trendCount: 56,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        user: {
          'full_name': 'Anand Kumar',
          'major': 'Alumni · SDE @ Google'
        },
        referral: {
          'id': 'r2',
          'post_id': '3',
          'user_id': 'u3',
          'company': 'Google',
          'role_title': 'SDE-2',
          'location': 'Hyderabad',
          'status': 'open',
          'applicants_count': 38,
        },
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: dummyPosts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return PostCard(post: dummyPosts[index]);
      },
    );
  }
}