import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/post_service.dart';
import '../../../core/services/wall_service.dart';
import '../../../shared/models/post_model.dart';
import '../../../shared/models/referral_model.dart';
import '../../../shared/widgets/intouch_avatar.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../shared/widgets/intouch_badge.dart';
import 'post_actions.dart';
import 'referral_card.dart';
import '../../../core/services/referral_service.dart';

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
  bool _isLoadingActions = true;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.post.likesCount;
    _trendCount = widget.post.trendCount;
    _loadActionStates();
  }

  Future<void> _loadActionStates() async {
    final liked = await PostService.isLiked(widget.post.id);
    final trended = await PostService.isTrended(widget.post.id);
    final walled = await WallService.isWalled(widget.post.userId);
    if (mounted) {
      setState(() {
        _isLiked = liked;
        _isTrended = trended;
        _isWalled = walled;
        _isLoadingActions = false;
      });
    }
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
    if (user == null) return widget.post.timeAgo;
    final parts = <String>[];
    if (user['major'] != null) parts.add(user['major']);
    parts.add(widget.post.timeAgo);
    return parts.join(' · ');
  }

  Future<void> _handleLike() async {
    final wasLiked = _isLiked;
    setState(() {
      _isLiked = !wasLiked;
      _likesCount += wasLiked ? -1 : 1;
    });
    if (wasLiked) {
      await PostService.unlikePost(widget.post.id);
    } else {
      await PostService.likePost(widget.post.id);
    }
  }

  Future<void> _handleTrend() async {
    final wasTrended = _isTrended;
    setState(() {
      _isTrended = !wasTrended;
      _trendCount += wasTrended ? -1 : 1;
    });
    if (wasTrended) {
      await PostService.untrendPost(widget.post.id);
    } else {
      await PostService.trendPost(widget.post.id);
    }
  }

  Future<void> _handleWall() async {
    final wasWalled = _isWalled;
    setState(() => _isWalled = !wasWalled);
    if (wasWalled) {
      await WallService.unwallUser(widget.post.userId);
    } else {
      await WallService.wallUser(widget.post.userId);
    }
  }

  void _handleApply() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.bgPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _ApplySheet(
        referralId: widget.post.referral?['id'] ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final referralData = widget.post.referral;
    final referral =
        referralData != null ? ReferralModel.fromJson(referralData) : null;

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
            Row(
              children: [
                IntouchAvatar(initials: _userInitials, size: 34),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(_userName,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textPrimary)),
                          const SizedBox(width: 4),
                          const VerifiedBadge(size: 12),
                        ],
                      ),
                      Text(_userSub,
                          style: const TextStyle(
                              fontSize: 10, color: AppTheme.textHint)),
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
            Text(widget.post.content,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.5)),
            if (referral != null) ...[
              const SizedBox(height: 8),
              ReferralInfoCard(referral: referral),
            ],
            const SizedBox(height: 6),
            if (_isLoadingActions)
              const SizedBox(height: 32)
            else
              PostActions(
                likesCount: _likesCount,
                commentsCount: widget.post.commentsCount,
                trendCount: _trendCount,
                isReferral: widget.post.isReferral,
                isLiked: _isLiked,
                isTrended: _isTrended,
                isWalled: _isWalled,
                onLike: _handleLike,
                onComment: () {},
                onTrend: _handleTrend,
                onWall: _handleWall,
                onApply: widget.post.isReferral ? _handleApply : null,
              ),
          ],
        ),
      ),
    );
  }
}

class _ApplySheet extends StatefulWidget {
  final String referralId;
  const _ApplySheet({required this.referralId});

  @override
  State<_ApplySheet> createState() => _ApplySheetState();
}

class _ApplySheetState extends State<_ApplySheet> {
  final _linkedinController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Apply for referral',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 6),
          const Text('Share your LinkedIn profile with the referrer.',
              style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
          const SizedBox(height: 16),
          TextField(
            controller: _linkedinController,
            decoration: const InputDecoration(
              hintText: 'https://linkedin.com/in/yourname',
              prefixIcon: Icon(Icons.link, size: 18),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _apply,
            child: _isLoading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                : const Text('Submit application'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _apply() async {
    if (_linkedinController.text.isEmpty) return;
    setState(() => _isLoading = true);

    final success = await ReferralService.applyToReferral(
      referralId: widget.referralId,
      linkedinUrl: _linkedinController.text.trim(),
    );

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Application submitted successfully!'
              : 'Failed to apply. Try again.'),
          backgroundColor: success ? AppTheme.success : AppTheme.danger,
        ),
      );
    }
  }
}

// Need to import ReferralService
