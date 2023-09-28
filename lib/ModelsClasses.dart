class Report {
  final String id;
  final String reportTitle;
  final User user;
  final String reportDescription;
  final String community;
  final String image1;
  final String image2;
  final String image3;
  final String status;
  final List<dynamic> feedback;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.reportTitle,
    required this.user,
    required this.reportDescription,
    required this.community,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.status,
    required this.feedback,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'],
      reportTitle: json['reportTitle'],
      user: User.fromJson(json['user']),
      reportDescription: json['reportDescription'],
      community: json['community'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      status: json['status'],
      feedback: json['feedback'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String address;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}
