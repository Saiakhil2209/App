import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TrendButton extends StatefulWidget {
  final int count;
  final bool isTrended;
  final VoidCallback onTap;

  const TrendButton({
    super.key,
    required this.count,
    required this.isTrended,
    required this.onTap,
  });

  @override
  State<TrendButton> createState() => _TrendButtonState();
}

class _TrendButtonState extends State<TrendButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: widget.isTrended
              ? AppTheme.warningLight
              : AppTheme.bgPrimary,
          border: Border.all(
            color: widget.isTrended
                ? AppTheme.warning
                : AppTheme.border,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🔥',
              style: const TextStyle(fontSize: 11),
            ),
            const SizedBox(width: 3),
            Text(
              widget.isTrended ? 'Trended' : 'Trend',
              style: TextStyle(
                fontSize: 10,
                fontWeight: widget.isTrended
                    ? FontWeight.w500
                    : FontWeight.normal,
                color: widget.isTrended
                    ? AppTheme.warningText
                    : AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WallButton extends StatefulWidget {
  final bool isWalled;
  final VoidCallback onTap;

  const WallButton({
    super.key,
    required this.isWalled,
    required this.onTap,
  });

  @override
  State<WallButton> createState() => _WallButtonState();
}

class _WallButtonState extends State<WallButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: widget.isWalled
              ? AppTheme.successLight
              : AppTheme.bgPrimary,
          border: Border.all(
            color: widget.isWalled
                ? AppTheme.successBorder
                : AppTheme.border,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.isWalled ? '✓ Walled' : '+ Wall',
          style: TextStyle(
            fontSize: 10,
            fontWeight: widget.isWalled
                ? FontWeight.w500
                : FontWeight.normal,
            color: widget.isWalled
                ? AppTheme.successText
                : AppTheme.textMuted,
          ),
        ),
      ),
    );
  }
}