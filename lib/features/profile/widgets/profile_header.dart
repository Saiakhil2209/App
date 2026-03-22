import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/intouch_avatar.dart';
import '../../../shared/widgets/verified_badge.dart';

class ProfileHeader extends StatelessWidget {
  final bool isOwnProfile;
  final bool isWalled;
  final VoidCallback onWallToggle;

  const ProfileHeader({
    super.key,
    required this.isOwnProfile,
    required this.isWalled,
    required this.onWallToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgPrimary,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntouchAvatar(
                initials: isOwnProfile ? 'SA' : 'AK',
                size: 64,
                backgroundColor: isOwnProfile
                    ? AppTheme.primaryLight
                    : const Color(0xFFFDF2F8),
                textColor: isOwnProfile
                    ? AppTheme.primary
                    : const Color(0xFF72243E),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          isOwnProfile ? 'Sai Akhil' : 'Anand Kumar',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const VerifiedBadge(size: 14),
                      ],
                    ),
                    Text(
                      isOwnProfile ? '@saiakhil' : '@anandkumar',
                      style: const TextStyle(fontSize: 12, color: AppTheme.textHint),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isOwnProfile
                          ? 'KITS Warangal · 2026 passout'
                          : 'KITS Warangal · 2022 passout · Alumni',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isOwnProfile
                          ? 'CSE student. Into tech, startups, and building things.'
                          : 'SDE at Google. KITS CSE 2022. Happy to help juniors.',
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Stats
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.border, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _Stat(count: isOwnProfile ? '18' : '92', label: 'Walled by you'),
                _Stat(count: isOwnProfile ? '34' : '210', label: 'Walled you'),
                _Stat(count: isOwnProfile ? '12' : '28', label: 'Posts'),
                _Stat(count: isOwnProfile ? '3' : '11', label: 'Referrals', isLast: true),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Tags
          Wrap(
            spacing: 6,
            children: ['Tech', 'Startups', 'DSA', 'ML/AI'].map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(fontSize: 10, color: AppTheme.referralText),
                ),
              );
            }).toList(),
          ),
          if (!isOwnProfile) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onWallToggle,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: isWalled ? AppTheme.successLight : AppTheme.primary,
                        border: Border.all(
                          color: isWalled ? AppTheme.successBorder : AppTheme.primary,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isWalled ? '✓ Walled' : '+ Wall',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isWalled ? AppTheme.successText : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: AppTheme.bgPrimary,
                      border: Border.all(color: AppTheme.border, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Message',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.bgPrimary,
                    border: Border.all(color: AppTheme.border, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('···', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String count;
  final String label;
  final bool isLast;

  const _Stat({required this.count, required this.label, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            right: isLast ? BorderSide.none : const BorderSide(color: AppTheme.border, width: 0.5),
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.textPrimary),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, color: AppTheme.textHint),
            ),
          ],
        ),
      ),
    );
  }
}