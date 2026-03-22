import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'profile_setup_screen.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _degree = 'B.Tech';
  String _major = 'Computer Science (CSE)';
  String _passoutYear = '2026';
  bool _isAlumni = false;

  final List<String> _degrees = ['B.Tech', 'M.Tech', 'MBA', 'PhD', 'B.Sc', 'M.Sc'];
  final List<String> _majors = [
    'Computer Science (CSE)',
    'Electronics (ECE)',
    'Mechanical (Mech)',
    'Civil',
    'Information Technology (IT)',
    'Electrical (EEE)',
    'Chemical',
    'Other',
  ];
  final List<String> _years = List.generate(10, (i) => '${2020 + i}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppTheme.bgPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildDots(3),
              const SizedBox(height: 20),
              const Text(
                'Your education',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'This determines your cohort group.',
                style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      border: Border.all(color: AppTheme.primaryBorder, width: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Degree 1',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _DropdownField(
                          label: 'Degree type',
                          value: _degree,
                          items: _degrees,
                          onChanged: (v) => setState(() => _degree = v!),
                        ),
                        const SizedBox(height: 10),
                        _DropdownField(
                          label: 'Branch / Major',
                          value: _major,
                          items: _majors,
                          onChanged: (v) => setState(() => _major = v!),
                        ),
                        const SizedBox(height: 10),
                        _DropdownField(
                          label: _isAlumni ? 'Passout year' : 'Expected passout year',
                          value: _passoutYear,
                          items: _years,
                          onChanged: (v) => setState(() => _passoutYear = v!),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Checkbox(
                              value: _isAlumni,
                              onChanged: (v) => setState(() => _isAlumni = v!),
                              activeColor: AppTheme.primary,
                            ),
                            const Text(
                              'I have already graduated (alumni)',
                              style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Icon(Icons.add, size: 16, color: AppTheme.primary),
                    SizedBox(width: 4),
                    Text(
                      'Add another degree',
                      style: TextStyle(fontSize: 13, color: AppTheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
                ),
                child: const Text('Continue'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots(int active) {
    return Row(
      children: List.generate(6, (i) {
        final isActive = i + 1 == active;
        final isDone = i + 1 < active;
        return Container(
          margin: const EdgeInsets.only(right: 6),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? AppTheme.primary
                : isDone
                    ? AppTheme.primaryBorder
                    : AppTheme.bgTertiary,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13))))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}