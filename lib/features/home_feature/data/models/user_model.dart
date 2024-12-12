class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final String createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        image: json['image'],
        createdAt: json['createdAt'],
      );
}
