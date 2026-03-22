import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class VisibilityPicker extends StatefulWidget {
  const VisibilityPicker({super.key});

  @override
  State<VisibilityPicker> createState() => _VisibilityPickerState();
}

class _VisibilityPickerState extends State<VisibilityPicker> {
  String _selected = 'KITS 2026 cohort';

  final List<Map<String, dynamic>> _options = [
    {'label': 'KITS 2026 cohort', 'sub': '142 batchmates only', 'icon': '👥', 'bg': Color(0xFFF0FDF4)},
    {'label': 'KITS Alumni page', 'sub': 'All KITS students + alumni', 'icon': '🎓', 'bg': Color(0xFFEEF2FF)},
    {'label': 'Hyd Tech Jobs group', 'sub': '2.4k members', 'icon': 'H', 'bg': Color(0xFFFEF3C7)},
    {'label': 'My wall', 'sub': 'Everyone who walled you', 'icon': '☕', 'bg': Color(0xFFFDF2F8)},
    {'label': 'Global — everyone', 'sub': 'Entire Intouch platform', 'icon': '🌍', 'bg': Color(0xFFF3F4F6)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppTheme.bgPrimary,
        elevation: 0,
        title: const Text('Who can see this post?'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context, _selected),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _options.map((option) {
          final isSelected = _selected == option['label'];
          return GestureDetector(
            onTap: () {
              setState(() => _selected = option['label']);
              Future.delayed(const Duration(milliseconds: 150), () {
                Navigator.pop(context, _selected);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryLight : AppTheme.bgPrimary,
                border: Border.all(
                  color: isSelected ? AppTheme.primary : AppTheme.border,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: option['bg'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        option['icon'] as String,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option['label'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          option['sub'] as String,
                          style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle, color: AppTheme.primary, size: 18),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}