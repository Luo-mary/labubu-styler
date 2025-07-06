class User {
  final String id;
  final String email;
  final String? phone;
  final int credits;
  final double totalSpent;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    this.phone,
    required this.credits,
    required this.totalSpent,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Handle Firestore timestamp
    DateTime createdAt;
    if (json['createdAt'] != null) {
      if (json['createdAt'] is DateTime) {
        createdAt = json['createdAt'];
      } else {
        // Handle Firestore Timestamp
        createdAt = json['createdAt'].toDate();
      }
    } else {
      createdAt = DateTime.now();
    }
    
    return User(
      id: json['id'],
      email: json['email'] ?? '',
      phone: json['phone'],
      credits: json['credits'] ?? 0,
      totalSpent: (json['totalSpent'] ?? 0).toDouble(),
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'credits': credits,
      'totalSpent': totalSpent,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? phone,
    int? credits,
    double? totalSpent,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      credits: credits ?? this.credits,
      totalSpent: totalSpent ?? this.totalSpent,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}