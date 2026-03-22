import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PendingVouchScreen extends StatefulWidget {
  const PendingVouchScreen({super.key});

  @override
  State<PendingVouchScreen> createState() => _PendingVouchScreenState();
}

class _PendingVouchScreenState extends State<PendingVouchScreen> {
  int _vouchCount = 1;
  bool _isApproved = false;

  void _simulateVouch() {
    if (_vouchCount < 3) {
      setState(() => _vouchCount++);
      if (_vouchCount == 3) {
        setState(() => _isApproved = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _isApproved ? AppTheme.successLight : AppTheme.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _isApproved ? '🎉' : '🔒',
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _isApproved ? "You're in!" : 'Almost there!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isApproved
                    ? 'Welcome to KITS Warangal 2026. Your cohort is waiting.'
                    : 'Your request to join KITS Warangal 2026 is pending.\nYou need 3 classmates to vouch for you.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textMuted,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _vouchCount / 3,
                  backgroundColor: AppTheme.bgTertiary,
                  color: _isApproved ? AppTheme.success : AppTheme.primary,
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isApproved
                    ? 'All 3 vouches received!'
                    : '$_vouchCount of 3 vouches received',
                style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 28),
              if (!_isApproved) ...[
                _ShareButton(
                  icon: '💬',
                  iconBg: const Color(0xFF25D366),
                  label: 'Share via WhatsApp',
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _ShareButton(
                  icon: '📷',
                  iconBg: const Color(0xFFE1306C),
                  label: 'Share via Instagram',
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _simulateVouch,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.bgSecondary,
                      border: Border.all(color: AppTheme.border, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '🔗 Copy profile link',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppTheme.primary),
                    ),
                  ),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  child: const Text('Go to my feed →'),
                ),
              ],
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  final String icon;
  final Color iconBg;
  final String label;
  final VoidCallback onTap;

  const _ShareButton({
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.bgPrimary,
          border: Border.all(color: AppTheme.border, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 14))),
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}