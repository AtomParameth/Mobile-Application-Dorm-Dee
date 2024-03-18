import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final List<String> favdorm;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.favdorm,
  });

  static UserModel empty() {
    return UserModel(
      id: "",
      userName: "",
      email: "",
      phoneNumber: "",
      profilePicture: "",
      favdorm: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
      "favdorm": favdorm,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      userName: map['userName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profilePicture: map['profilePicture'],
      favdorm: List<String>.from(map['favdorm'] ?? []),
    );
  }
  
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return UserModel.empty();
    } else {
      final data = document.data()!;
      return UserModel(
        id: data["id"] ?? "",
        userName: data["userName"] ?? "",
        email: data["email"] ?? "",
        phoneNumber: data["phoneNumber"] ?? "",
        profilePicture: data["profilePicture"] ?? "",
        favdorm: List<String>.from(data["favdorm"] ?? []),
      );
    }
    
  }
}
