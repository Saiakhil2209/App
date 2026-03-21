import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/intouch_avatar.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String userSub;
  final String initials;
  final int walledByYouCount;
  final int walledYouCount;
  final String activeSpaceId;
  final Function(String id, String name, String sub) onSpaceSelected;

  const AppDrawer({
    super.key,
    required this.userName,
    required this.userSub,
    required this.initials,
    required this.walledByYouCount,
    required this.walledYouCount,
    required this.activeSpaceId,
    required this.onSpaceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.bgPrimary,
      child: SafeArea(
        child: Column(
          children: [
            // Profile section
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF8F9FF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntouchAvatar(initials: initials, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    userSub,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _StatChip(
                        count: walledByYouCount,
                        label: 'Walled by you',
                      ),
                      const SizedBox(width: 16),
                      _StatChip(
                        count: walledYouCount,
                        label: 'Walled you',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // My College
                  _DrawerSection(label: 'MY COLLEGE'),
                  _DrawerItem(
                    icon: 'K',
                    iconBg: AppTheme.primaryLight,
                    iconColor: AppTheme.primary,
                    label: 'KITS Alumni page',
                    isActive: activeSpaceId == 'alumni',
                    onTap: () {
                      onSpaceSelected(
                        'alumni',
                        'KITS Alumni Page',
                        'All years · all branches',
                      );
                      Navigator.pop(context);
                    },
                  ),

                  // My Cohort
                  _DrawerSection(label: 'MY COHORT'),
                  _DrawerItem(
                    icon: '26',
                    iconBg: AppTheme.successLight,
                    iconColor: AppTheme.successText,
                    label: 'KITS 2026',
                    badge: '142',
                    isActive: activeSpaceId == 'cohort',
                    onTap: () {
                      onSpaceSelected(
                        'cohort',
                        'KITS Warangal 2026',
                        '142 members · your cohort',
                      );
                      Navigator.pop(context);
                    },
                  ),

                  // My Groups
                  _DrawerSection(label: 'MY GROUPS'),
                  _DrawerItem(
                    icon: 'H',
                    iconBg: AppTheme.warningLight,
                    iconColor: AppTheme.warningText,
                    label: 'Hyd Tech Jobs',
                    isActive: activeSpaceId == 'hyd',
                    onTap: () {
                      onSpaceSelected(
                        'hyd',
                        'Hyd Tech Jobs',
                        '2.4k members · open group',
                      );
                      Navigator.pop(context);
                    },
                  ),
                  _DrawerItem(
                    icon: 'J',
                    iconBg: const Color(0xFFFDF2F8),
                    iconColor: const Color(0xFF72243E),
                    label: 'Java Developers',
                    isActive: activeSpaceId == 'java',
                    onTap: () {
                      onSpaceSelected(
                        'java',
                        'Java Developers',
                        '890 members · open group',
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Text(
                      '+ Discover groups',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.primary,
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),

                  // Discover
                  _DrawerSection(label: 'DISCOVER'),
                  _DrawerItem(
                    icon: '🔥',
                    iconBg: AppTheme.warningLight,
                    iconColor: AppTheme.warningText,
                    label: 'Trending',
                    isActive: activeSpaceId == 'trending',
                    onTap: () {
                      onSpaceSelected(
                        'trending',
                        'Trending',
                        'Hot posts across Intouch',
                      );
                      Navigator.pop(context);
                    },
                  ),
                  _DrawerItem(
                    icon: '🌍',
                    iconBg: AppTheme.bgTertiary,
                    iconColor: AppTheme.textMuted,
                    label: 'Global',
                    isActive: activeSpaceId == 'global',
                    onTap: () {
                      onSpaceSelected(
                        'global',
                        'Global Feed',
                        'Everyone on Intouch',
                      );
                      Navigator.pop(context);
                    },
                  ),

                  const Divider(height: 1),

                  // Walled by you
                  _DrawerSection(label: 'WALLED BY YOU ($walledByYouCount)'),
                  _WallPerson(
                    initials: 'AK',
                    name: 'Anand Kumar',
                    sub: 'SDE @ Google',
                  ),
                  _WallPerson(
                    initials: 'RK',
                    name: 'Rahul Kumar',
                    sub: 'KITS 2026 · CSE',
                    hasNew: true,
                  ),

                  const Divider(height: 1),

                  // Account
                  _DrawerSection(label: 'ACCOUNT'),
                  _DrawerItem(
                    icon: 'P',
                    iconBg: AppTheme.bgTertiary,
                    iconColor: AppTheme.textMuted,
                    label: 'Profile',
                    onTap: () => Navigator.pop(context),
                  ),
                  _DrawerItem(
                    icon: 'S',
                    iconBg: AppTheme.bgTertiary,
                    iconColor: AppTheme.textMuted,
                    label: 'Settings',
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    dense: true,
                    leading: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppTheme.dangerLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.logout,
                        size: 13,
                        color: AppTheme.danger,
                      ),
                    ),
                    title: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.danger,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerSection extends StatelessWidget {
  final String label;
  const _DrawerSection({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 3),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: AppTheme.textHint,
          letterSpacing: 0.05,
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String? badge;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    this.badge,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: isActive ? AppTheme.primaryLight : null,
      leading: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            icon,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: iconColor,
            ),
          ),
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: isActive ? AppTheme.primary : AppTheme.textSecondary,
          fontWeight:
              isActive ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppTheme.referralText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}

class _WallPerson extends StatelessWidget {
  final String initials;
  final String name;
  final String sub;
  final bool hasNew;

  const _WallPerson({
    required this.initials,
    required this.name,
    required this.sub,
    this.hasNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: IntouchAvatar(initials: initials, size: 28),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimary,
        ),
      ),
      subtitle: Text(
        sub,
        style: const TextStyle(
          fontSize: 10,
          color: AppTheme.textMuted,
        ),
      ),
      trailing: hasNew
          ? Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}

class _StatChip extends StatelessWidget {
  final int count;
  final String label;

  const _StatChip({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: AppTheme.textHint,
          ),
        ),
      ],
    );
  }
}