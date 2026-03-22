import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/notification_service.dart';
import '../../../shared/widgets/intouch_avatar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await NotificationService.getNotifications();
    if (mounted) setState(() {
      _notifications = data;
      _isLoading = false;
    });
  }

  String _notifText(Map<String, dynamic> notif) {
    switch (notif['type']) {
      case 'like': return 'liked your post';
      case 'comment': return 'commented on your post';
      case 'vouch': return 'vouched for you';
      case 'wall': return 'walled you';
      case 'referral': return 'applied to your referral';
      case 'trend': return 'trended your post';
      default: return 'interacted with you';
    }
  }

  String _timeAgo(String? createdAt) {
    if (createdAt == null) return '';
    final diff = DateTime.now().difference(DateTime.parse(createdAt));
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSecondary,
      appBar: AppBar(
        backgroundColor: AppTheme.bgPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () async {
              await NotificationService.markAllRead();
              _load();
            },
            child: const Text('Mark all read',
                style: TextStyle(fontSize: 12, color: AppTheme.primary)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primary))
          : _notifications.isEmpty
              ? const Center(
                  child: Text('No notifications yet',
                      style: TextStyle(color: AppTheme.textMuted)))
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final notif = _notifications[index];
                    final actor = notif['actor'] as Map<String, dynamic>?;
                    final isUnread = !(notif['is_read'] ?? false);
                    final name = actor?['full_name'] ?? 'Someone';
                    final initials = name.isNotEmpty
                        ? name.split(' ').take(2).map((p) => p[0]).join().toUpperCase()
                        : '?';

                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUnread
                            ? AppTheme.primaryLight.withOpacity(0.3)
                            : AppTheme.bgPrimary,
                        border: Border.all(
                            color: AppTheme.border, width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IntouchAvatar(initials: initials, size: 36),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: name,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.textPrimary),
                                      ),
                                      TextSpan(
                                        text: ' ${_notifText(notif)}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.textSecondary),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _timeAgo(notif['created_at']),
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: AppTheme.textHint),
                                ),
                              ],
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}