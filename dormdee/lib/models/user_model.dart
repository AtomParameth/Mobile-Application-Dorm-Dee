import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String profilePicture;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  static UserModel empty() {
    return UserModel(
      id: "",
      userName: "",
      email: "",
      phoneNumber: "",
      profilePicture: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
    };
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
      );
    }
  }
}
