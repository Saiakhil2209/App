class ReferralModel {
  final String id;
  final String postId;
  final String userId;
  final String company;
  final String? companyNormalized;
  final String? roleTitle;
  final String? location;
  final String? experienceLevel;
  final String status;
  final int applicantsCount;
  final DateTime? createdAt;

  ReferralModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.company,
    this.companyNormalized,
    this.roleTitle,
    this.location,
    this.experienceLevel,
    this.status = 'open',
    this.applicantsCount = 0,
    this.createdAt,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      company: json['company'],
      companyNormalized: json['company_normalized'],
      roleTitle: json['role_title'],
      location: json['location'],
      experienceLevel: json['experience_level'],
      status: json['status'] ?? 'open',
      applicantsCount: json['applicants_count'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  bool get isOpen => status == 'open';
}