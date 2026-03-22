import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'pending_vouch_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  final List<String> _allInterests = [
    'Tech', 'DSA', 'Startups', 'Design', 'Finance',
    'ML/AI', 'Gaming', 'Music', 'Sports', 'Photography',
    'Writing', 'Research',
  ];
  final Set<String> _selectedInterests = {'Tech', 'Startups'};

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildDots(4),
              const SizedBox(height: 20),
              const Text(
                'Set up your profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryLight,
                        border: Border.all(color: AppTheme.primaryBorder, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'SA',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Center(
                child: Text(
                  'Upload photo',
                  style: TextStyle(fontSize: 12, color: AppTheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              _buildLabel('Full name'),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Your full name'),
              ),
              const SizedBox(height: 14),
              _buildLabel('Username'),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: '@username'),
              ),
              const SizedBox(height: 14),
              _buildLabel('Short bio'),
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(hintText: 'CSE student, KITS 2026'),
              ),
              const SizedBox(height: 20),
              _buildLabel('Interests (pick any)'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _allInterests.map((interest) {
                  final selected = _selectedInterests.contains(interest);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selected) {
                          _selectedInterests.remove(interest);
                        } else {
                          _selectedInterests.add(interest);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? AppTheme.primaryLight : AppTheme.bgPrimary,
                        border: Border.all(
                          color: selected ? AppTheme.primary : AppTheme.border,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        interest,
                        style: TextStyle(
                          fontSize: 12,
                          color: selected ? AppTheme.primary : AppTheme.textSecondary,
                          fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PendingVouchScreen()),
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

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppTheme.textSecondary,
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