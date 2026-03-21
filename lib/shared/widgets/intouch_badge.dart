import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum BadgeType { referral, post, trending, alumni, current }

class IntouchBadge extends StatelessWidget {
  final BadgeType type;
  final String? customLabel;

  const IntouchBadge({super.key, required this.type, this.customLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        customLabel ?? _label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: _textColor,
        ),
      ),
    );
  }

  String get _label {
    switch (type) {
      case BadgeType.referral:
        return 'Referral';
      case BadgeType.post:
        return 'Post';
      case BadgeType.trending:
        return 'Trending';
      case BadgeType.alumni:
        return 'Alumni';
      case BadgeType.current:
        return 'Current';
    }
  }

  Color get _backgroundColor {
    switch (type) {
      case BadgeType.referral:
        return AppTheme.referralBg;
      case BadgeType.post:
        return AppTheme.successLight;
      case BadgeType.trending:
        return AppTheme.warningLight;
      case BadgeType.alumni:
        return AppTheme.successLight;
      case BadgeType.current:
        return AppTheme.primaryLight;
    }
  }

  Color get _textColor {
    switch (type) {
      case BadgeType.referral:
        return AppTheme.referralText;
      case BadgeType.post:
        return AppTheme.successText;
      case BadgeType.trending:
        return AppTheme.warningText;
      case BadgeType.alumni:
        return AppTheme.successText;
      case BadgeType.current:
        return AppTheme.primaryDark;
    }
  }
}