import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'education_screen.dart';

class CollegeScreen extends StatefulWidget {
  const CollegeScreen({super.key});

  @override
  State<CollegeScreen> createState() => _CollegeScreenState();
}

class _CollegeScreenState extends State<CollegeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showResults = false;
  String? _selectedCollege;

  final List<Map<String, String>> _mockColleges = [
    {'name': 'Kakatiya Institute of Technology', 'city': 'Warangal', 'state': 'Telangana', 'members': '2.1k'},
    {'name': 'NIT Warangal', 'city': 'Warangal', 'state': 'Telangana', 'members': '3.4k'},
    {'name': 'JNTU Hyderabad', 'city': 'Hyderabad', 'state': 'Telangana', 'members': '5.2k'},
    {'name': 'Osmania University', 'city': 'Hyderabad', 'state': 'Telangana', 'members': '4.1k'},
    {'name': 'IIT Hyderabad', 'city': 'Hyderabad', 'state': 'Telangana', 'members': '1.8k'},
  ];

  List<Map<String, String>> get _filteredColleges {
    if (_searchController.text.length < 2) return [];
    return _mockColleges
        .where((c) => c['name']!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();
  }

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
              _StepIndicator(step: 2, total: 6),
              const SizedBox(height: 20),
              const Text(
                'Find your college',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Search for your college. If not listed, you can add it.',
                style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _showResults = val.length >= 2),
                decoration: const InputDecoration(
                  hintText: 'e.g. KITS, NIT, JNTU...',
                  prefixIcon: Icon(Icons.search, size: 18, color: AppTheme.textMuted),
                ),
              ),
              const SizedBox(height: 12),
              if (_showResults && _selectedCollege == null) ...[
                ..._filteredColleges.map((college) => _CollegeResult(
                  name: college['name']!,
                  location: '${college['city']}, ${college['state']}',
                  members: college['members']!,
                  onTap: () {
                    setState(() {
                      _selectedCollege = college['name'];
                      _searchController.text = college['name']!;
                      _showResults = false;
                    });
                  },
                )),
                if (_filteredColleges.isEmpty)
                  GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '+ Add my college — not listed above',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ),
              ],
              if (_selectedCollege != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.successLight,
                    border: Border.all(color: AppTheme.successBorder, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppTheme.success, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedCollege!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.successText,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _selectedCollege = null),
                        child: const Icon(Icons.close, size: 16, color: AppTheme.textMuted),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              ElevatedButton(
                onPressed: _selectedCollege != null
                    ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const EducationScreen()))
                    : null,
                child: const Text('Continue'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _CollegeResult extends StatelessWidget {
  final String name;
  final String location;
  final String members;
  final VoidCallback onTap;

  const _CollegeResult({
    required this.name,
    required this.location,
    required this.members,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: AppTheme.bgSecondary,
          border: Border.all(color: AppTheme.border, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$members members',
                style: const TextStyle(
                  fontSize: 9,
                  color: AppTheme.referralText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int step;
  final int total;

  const _StepIndicator({required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final isActive = i + 1 == step;
        final isDone = i + 1 < step;
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