class UserModel {
  final String id;
  final String? fullName;
  final String? username;
  final String? avatarUrl;
  final String? bio;
  final List<String>? interests;
  final String? linkedinUrl;
  final String? currentCompany;
  final bool isDeleted;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    this.fullName,
    this.username,
    this.avatarUrl,
    this.bio,
    this.interests,
    this.linkedinUrl,
    this.currentCompany,
    this.isDeleted = false,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      username: json['username'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      interests: json['interests'] != null
          ? List<String>.from(json['interests'])
          : null,
      linkedinUrl: json['linkedin_url'],
      currentCompany: json['current_company'],
      isDeleted: json['is_deleted'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'username': username,
      'avatar_url': avatarUrl,
      'bio': bio,
      'interests': interests,
      'linkedin_url': linkedinUrl,
      'current_company': currentCompany,
      'is_deleted': isDeleted,
    };
  }

  String get initials {
    if (fullName == null || fullName!.isEmpty) return '?';
    final parts = fullName!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return fullName![0].toUpperCase();
  }
}