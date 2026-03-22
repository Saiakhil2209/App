import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class WorkTab extends StatelessWidget {
  const WorkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('WORK EXPERIENCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.textMuted, letterSpacing: 0.05)),
            GestureDetector(
              onTap: () {},
              child: const Text('+ Add', style: TextStyle(fontSize: 12, color: AppTheme.primary)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _WorkItem(
          letter: 'G',
          color: const Color(0xFF4285F4),
          company: 'Google',
          role: 'Software Development Engineer',
          duration: 'Aug 2022 — Present · Hyderabad',
          isCurrent: true,
          canRefer: true,
        ),
        const SizedBox(height: 12),
        _WorkItem(
          letter: 'A',
          color: const Color(0xFFFF9900),
          company: 'Amazon',
          role: 'SDE Intern',
          duration: 'May 2021 — Jul 2021 · Hyderabad',
          isCurrent: false,
          canRefer: false,
        ),
      ],
    );
  }
}

class _WorkItem extends StatefulWidget {
  final String letter;
  final Color color;
  final String company;
  final String role;
  final String duration;
  final bool isCurrent;
  final bool canRefer;

  const _WorkItem({
    required this.letter,
    required this.color,
    required this.company,
    required this.role,
    required this.duration,
    required this.isCurrent,
    required this.canRefer,
  });

  @override
  State<_WorkItem> createState() => _WorkItemState();
}

class _WorkItemState extends State<_WorkItem> {
  late bool _canRefer;

  @override
  void initState() {
    super.initState();
    _canRefer = widget.canRefer;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              widget.letter,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.company, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
              Text(widget.role, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
              Text(widget.duration, style: const TextStyle(fontSize: 10, color: AppTheme.textHint)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.isCurrent ? 'Current' : 'Past',
                      style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppTheme.referralText),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => setState(() => _canRefer = !_canRefer),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _canRefer ? AppTheme.successLight : AppTheme.bgTertiary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _canRefer ? '✓ Can refer' : 'Can refer?',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: _canRefer ? AppTheme.successText : AppTheme.textMuted,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}