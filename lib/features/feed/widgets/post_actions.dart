import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/trend_wall_buttons.dart';

class PostActions extends StatefulWidget {
  final int likesCount;
  final int commentsCount;
  final int trendCount;
  final bool isReferral;
  final bool isLiked;
  final bool isTrended;
  final bool isWalled;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onTrend;
  final VoidCallback onWall;
  final VoidCallback? onApply;

  const PostActions({
    super.key,
    required this.likesCount,
    required this.commentsCount,
    required this.trendCount,
    required this.isReferral,
    required this.isLiked,
    required this.isTrended,
    required this.isWalled,
    required this.onLike,
    required this.onComment,
    required this.onTrend,
    required this.onWall,
    this.onApply,
  });

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.borderLight, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          _ActionBtn(
            icon: widget.isLiked ? '❤️' : '🤍',
            label: '${widget.likesCount}',
            isActive: widget.isLiked,
            onTap: widget.onLike,
          ),
          const SizedBox(width: 4),
          _ActionBtn(
            icon: '💬',
            label: '${widget.commentsCount}',
            onTap: widget.onComment,
          ),
          const SizedBox(width: 4),
          TrendButton(
            count: widget.trendCount,
            isTrended: widget.isTrended,
            onTap: widget.onTrend,
          ),
          const SizedBox(width: 4),
          WallButton(
            isWalled: widget.isWalled,
            onTap: widget.onWall,
          ),
          if (widget.isReferral && widget.onApply != null) ...[
            const Spacer(),
            GestureDetector(
              onTap: widget.onApply,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? AppTheme.danger : AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}