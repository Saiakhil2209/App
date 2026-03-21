class CollegeModel {
  final String id;
  final String name;
  final String? nameNormalized;
  final String? city;
  final String? state;
  final String status;
  final DateTime? createdAt;

  CollegeModel({
    required this.id,
    required this.name,
    this.nameNormalized,
    this.city,
    this.state,
    this.status = 'pending',
    this.createdAt,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['id'],
      name: json['name'],
      nameNormalized: json['name_normalized'],
      city: json['city'],
      state: json['state'],
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_normalized': nameNormalized,
      'city': city,
      'state': state,
      'status': status,
    };
  }

  String get fullLocation {
    if (city != null && state != null) return '$city, $state';
    if (city != null) return city!;
    if (state != null) return state!;
    return '';
  }
}