import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/post_model.dart';
import '../../../shared/models/referral_model.dart';
import '../../../shared/widgets/intouch_avatar.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../shared/widgets/intouch_badge.dart';
import 'post_actions.dart';
import 'referral_card.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onTap;

  const PostCard({super.key, required this.post, this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  bool _isTrended = false;
  bool _isWalled = false;
  late int _likesCount;
  late int _trendCount;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.post.likesCount;
    _trendCount = widget.post.trendCount;
  }

  String get _userName {
    final user = widget.post.user;
    if (user == null) return 'Unknown';
    return user['full_name'] ?? 'Unknown';
  }

  String get _userInitials {
    final name = _userName;
    if (name == 'Unknown') return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String get _userSub {
    final user = widget.post.user;
    if (user == null) return '';
    final parts = <String>[];
    if (user['major'] != null) parts.add(user['major']);
    parts.add(widget.post.timeAgo);
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final referralData = widget.post.referral;
    final referral = referralData != null
        ? ReferralModel.fromJson(referralData)
        : null;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.bgPrimary,
          border: Border.all(color: AppTheme.border, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                IntouchAvatar(
                  initials: _userInitials,
                  size: 34,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _userName,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const VerifiedBadge(size: 12),
                        ],
                      ),
                      Text(
                        _userSub,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                IntouchBadge(
                  type: widget.post.isReferral
                      ? BadgeType.referral
                      : BadgeType.post,
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Content
            Text(
              widget.post.content,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),

            // Referral info
            if (referral != null) ...[
              const SizedBox(height: 8),
              ReferralInfoCard(referral: referral),
            ],

            const SizedBox(height: 6),

            // Actions
            PostActions(
              likesCount: _likesCount,
              commentsCount: widget.post.commentsCount,
              trendCount: _trendCount,
              isReferral: widget.post.isReferral,
              isLiked: _isLiked,
              isTrended: _isTrended,
              isWalled: _isWalled,
              onLike: () {
                setState(() {
                  _isLiked = !_isLiked;
                  _likesCount += _isLiked ? 1 : -1;
                });
              },
              onComment: () {},
              onTrend: () {
                setState(() {
                  _isTrended = !_isTrended;
                  _trendCount += _isTrended ? 1 : -1;
                });
              },
              onWall: () {
                setState(() => _isWalled = !_isWalled);
              },
              onApply: widget.post.isReferral ? () {} : null,
            ),
          ],
        ),
      ),
    );
  }
}