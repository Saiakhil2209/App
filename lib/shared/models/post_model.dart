class PostModel {
  final String id;
  final String userId;
  final String? collegeId;
  final String? cohortGroupId;
  final String? openGroupId;
  final String content;
  final List<String>? mediaUrls;
  final String visibility;
  final bool isReferral;
  final DateTime? expiresAt;
  final int likesCount;
  final int commentsCount;
  final int trendCount;
  final DateTime? createdAt;
  final Map<String, dynamic>? user;
  final Map<String, dynamic>? referral;

  PostModel({
    required this.id,
    required this.userId,
    this.collegeId,
    this.cohortGroupId,
    this.openGroupId,
    required this.content,
    this.mediaUrls,
    this.visibility = 'cohort',
    this.isReferral = false,
    this.expiresAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.trendCount = 0,
    this.createdAt,
    this.user,
    this.referral,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      collegeId: json['college_id'],
      cohortGroupId: json['cohort_group_id'],
      openGroupId: json['open_group_id'],
      content: json['content'],
      mediaUrls: json['media_urls'] != null
          ? List<String>.from(json['media_urls'])
          : null,
      visibility: json['visibility'] ?? 'cohort',
      isReferral: json['is_referral'] ?? false,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      trendCount: json['trend_count'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      user: json['user'],
      referral: json['referral'],
    );
  }

  String get timeAgo {
    if (createdAt == null) return '';
    final diff = DateTime.now().difference(createdAt!);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}';
  }

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  int get daysUntilExpiry {
    if (expiresAt == null) return 0;
    return expiresAt!.difference(DateTime.now()).inDays;
  }
}