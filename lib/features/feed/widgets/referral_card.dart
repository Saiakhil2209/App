import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/referral_model.dart';

class ReferralInfoCard extends StatelessWidget {
  final ReferralModel referral;

  const ReferralInfoCard({super.key, required this.referral});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.bgSecondary,
        border: Border.all(color: AppTheme.border, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            referral.company,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          if (referral.roleTitle != null) ...[
            const SizedBox(height: 2),
            Text(
              referral.roleTitle!,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textMuted,
              ),
            ),
          ],
          const SizedBox(height: 6),
          Row(
            children: [
              if (referral.location != null)
                _MetaTag(
                  icon: '📍',
                  label: referral.location!,
                ),
              if (referral.location != null) const SizedBox(width: 10),
              _MetaTag(
                icon: '⏱',
                label: '${referral.applicantsCount} applied',
              ),
              const SizedBox(width: 10),
              _MetaTag(
                icon: '🟢',
                label: referral.isOpen ? 'Open' : 'Closed',
                color: referral.isOpen
                    ? AppTheme.successText
                    : AppTheme.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaTag extends StatelessWidget {
  final String icon;
  final String label;
  final Color? color;

  const _MetaTag({
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 10)),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color ?? AppTheme.textMuted,
          ),
        ),
      ],
    );
  }
}