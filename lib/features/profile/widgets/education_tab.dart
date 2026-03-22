import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EducationTab extends StatelessWidget {
  const EducationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('EDUCATION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.textMuted, letterSpacing: 0.05)),
            GestureDetector(
              onTap: () {},
              child: const Text('+ Add', style: TextStyle(fontSize: 12, color: AppTheme.primary)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _EduItem(
          icon: '🎓',
          college: 'Kakatiya Institute of Technology',
          degree: 'B.Tech · Computer Science (CSE)',
          year: '2022 — 2026 · Warangal',
          isAlumni: false,
        ),
      ],
    );
  }
}

class _EduItem extends StatelessWidget {
  final String icon;
  final String college;
  final String degree;
  final String year;
  final bool isAlumni;

  const _EduItem({
    required this.icon,
    required this.college,
    required this.degree,
    required this.year,
    required this.isAlumni,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text(icon, style: const TextStyle(fontSize: 16))),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(college, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
              Text(degree, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
              Text(year, style: const TextStyle(fontSize: 10, color: AppTheme.textHint)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.successLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isAlumni ? 'Alumni' : 'Current student',
                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppTheme.successText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}