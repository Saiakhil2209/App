import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/intouch_avatar.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../shared/widgets/intouch_badge.dart';
import '../widgets/profile_header.dart';
import '../widgets/education_tab.dart';
import '../widgets/work_tab.dart';

class ProfileScreen extends StatefulWidget {
  final bool isOwnProfile;
  const ProfileScreen({super.key, this.isOwnProfile = true});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tabIndex = 0;
  bool _isWalled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSecondary,
      appBar: AppBar(
        backgroundColor: AppTheme.bgPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
        actions: [
          if (widget.isOwnProfile)
            TextButton(
              onPressed: () {},
              child: const Text('Edit', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w500)),
            ),
        ],
      ),
      body: Column(
        children: [
          ProfileHeader(
            isOwnProfile: widget.isOwnProfile,
            isWalled: _isWalled,
            onWallToggle: () => setState(() => _isWalled = !_isWalled),
          ),
          // Tabs
          Container(
            color: AppTheme.bgPrimary,
            child: Row(
              children: ['Posts', 'Education', 'Work'].asMap().entries.map((e) {
                final isActive = e.key == _tabIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _tabIndex = e.key),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isActive ? AppTheme.primary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        e.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                          color: isActive ? AppTheme.primary : AppTheme.textMuted,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _tabIndex == 0
                ? _PostsTab()
                : _tabIndex == 1
                    ? const EducationTab()
                    : const WorkTab(),
          ),
        ],
      ),
    );
  }
}

class _PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = [
      {'badge': 'Referral', 'text': 'Need a referral at Amazon SDE-1', 'likes': '24', 'comments': '8'},
      {'badge': 'Post', 'text': 'Just cleared TCS NQT! Here\'s how...', 'likes': '47', 'comments': '19'},
      {'badge': 'Trending', 'text': 'Top DSA resources for placements 2026', 'likes': '112', 'comments': '34'},
      {'badge': 'Post', 'text': 'KITS placement season starts next month', 'likes': '31', 'comments': '7'},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.4,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        final badgeType = post['badge'] == 'Referral'
            ? BadgeType.referral
            : post['badge'] == 'Trending'
                ? BadgeType.trending
                : BadgeType.post;
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.bgPrimary,
            border: Border.all(color: AppTheme.border, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntouchBadge(type: badgeType),
              const SizedBox(height: 6),
              Text(
                post['text']!,
                style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                '♡ ${post['likes']}  💬 ${post['comments']}',
                style: const TextStyle(fontSize: 10, color: AppTheme.textHint),
              ),
            ],
          ),
        );
      },
    );
  }
}