import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/post_service.dart';
import 'visibility_picker.dart';
import '../../../core/services/referral_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  bool _isReferral = false;
  bool _isPosting = false;
  String _visibility = 'cohort';
  String _visibilityLabel = 'KITS 2026 cohort';

  Future<void> _post() async {
    if (_contentController.text.trim().isEmpty) return;
    setState(() => _isPosting = true);

    try {
      final post = await PostService.createPost(
        content: _contentController.text.trim(),
        visibility: _visibility,
        isReferral: _isReferral,
      );

      if (post != null && _isReferral &&
          _companyController.text.isNotEmpty) {
        await ReferralService.createReferral(
          postId: post.id,
          company: _companyController.text.trim(),
          roleTitle: _roleController.text.trim(),
          location: _locationController.text.trim(),
          experienceLevel: _experienceController.text.trim(),
        );
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post created!'),
            backgroundColor: AppTheme.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post: $e'),
            backgroundColor: AppTheme.danger,
          ),
        );
      }
    }
    if (mounted) setState(() => _isPosting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppTheme.bgPrimary,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel',
              style: TextStyle(color: AppTheme.textMuted)),
        ),
        title: const Text('New post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _isPosting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        color: AppTheme.primary, strokeWidth: 2))
                : ElevatedButton(
                    onPressed: _contentController.text.isNotEmpty
                        ? _post
                        : null,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60, 34),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16)),
                    child: const Text('Post'),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppTheme.bgTertiary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _TypeBtn(
                      label: 'Post',
                      isActive: !_isReferral,
                      onTap: () => setState(() => _isReferral = false),
                    ),
                    _TypeBtn(
                      label: 'Referral request',
                      isActive: _isReferral,
                      onTap: () => setState(() => _isReferral = true),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('SA',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.primary)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sai Akhil',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textPrimary)),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const VisibilityPicker()),
                          );
                          if (result != null) {
                            setState(() {
                              _visibility = result['key'];
                              _visibilityLabel = result['label'];
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.bgTertiary,
                            border: Border.all(
                                color: AppTheme.border, width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(_visibilityLabel,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: AppTheme.textSecondary)),
                              const Icon(Icons.arrow_drop_down,
                                  size: 14, color: AppTheme.textMuted),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _contentController,
                maxLines: 5,
                maxLength: 500,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: _isReferral
                      ? 'Describe what you need...'
                      : "What's on your mind?",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  counterStyle: const TextStyle(
                      fontSize: 10, color: AppTheme.textHint),
                ),
              ),
            ),
            if (_isReferral)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  border: Border.all(
                      color: AppTheme.primaryBorder, width: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('💼 Referral details',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.primary)),
                    const SizedBox(height: 10),
                    _ReferralField(
                        label: 'Company',
                        controller: _companyController,
                        hint: 'e.g. Amazon, Google'),
                    const SizedBox(height: 10),
                    _ReferralField(
                        label: 'Role / Position',
                        controller: _roleController,
                        hint: 'e.g. SDE-1'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _ReferralField(
                              label: 'Location',
                              controller: _locationController,
                              hint: 'Hyderabad'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _ReferralField(
                              label: 'Experience',
                              controller: _experienceController,
                              hint: 'Fresher'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.warningLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Text('⏱', style: TextStyle(fontSize: 12)),
                          SizedBox(width: 6),
                          Text('Auto-expires in 30 days',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.warningText)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: AppTheme.bgPrimary,
          border: Border(
              top: BorderSide(color: AppTheme.border, width: 0.5)),
        ),
        child: Row(
          children: [
            _ToolBtn(icon: Icons.image_outlined, onTap: () {}),
            const SizedBox(width: 12),
            _ToolBtn(icon: Icons.link, onTap: () {}),
            _ToolBtn(icon: Icons.alternate_email, onTap: () {}),
            _ToolBtn(icon: Icons.tag, onTap: () {}),
            const Spacer(),
            const Text('English only',
                style:
                    TextStyle(fontSize: 10, color: AppTheme.textHint)),
          ],
        ),
      ),
    );
  }
}

class _TypeBtn extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TypeBtn(
      {required this.label,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.bgPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? Border.all(color: AppTheme.border, width: 0.5)
                : null,
          ),
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? AppTheme.primary
                      : AppTheme.textMuted)),
        ),
      ),
    );
  }
}

class _ReferralField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;

  const _ReferralField(
      {required this.label,
      required this.controller,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}

class _ToolBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ToolBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppTheme.bgTertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppTheme.textMuted),
      ),
    );
  }
}