import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class IntouchAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;

  const IntouchAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.size = 36,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppTheme.primaryLight,
        border: Border.all(
          color: AppTheme.primaryBorder,
          width: 0.5,
        ),
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: size * 0.3,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppTheme.primary,
                ),
              ),
            )
          : null,
    );
  }
}