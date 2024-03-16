import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String user;
  final String userImage;
  final String userId;
  final int rating;
  final String description;
  final DateTime createdAt;

  RatingModel({
    required this.user,
    required this.userImage,
    required this.userId,
    required this.rating,
    required this.description,
    required this.createdAt,
  });

  static RatingModel empty() {
    return RatingModel(
      user: "",
      userImage: "",
      userId: "",
      rating: 0,
      description: "",
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "userImage": userImage,
      "userId": userId,
      "rating": rating,
      "description": description,
      "createdAt": createdAt,
    };
  }

  factory RatingModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return RatingModel.empty();
    } else {
      final data = document.data()!;
      return RatingModel(
        user: data["user"] ?? "",
        userImage: data["userImage"] ?? "",
        userId: data["userId"] ?? "",
        rating: data["rating"] ?? 0,
        description: data["description"] ?? "",
        createdAt:
            (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    }
  }

  factory RatingModel.fromMap(Map<String, dynamic> data) {
    return RatingModel(
      user: data["user"] ?? "",
      userImage: data["userImage"] ?? "",
      userId: data["userId"] ?? "",
      rating: data["rating"] ?? 0,
      description: data["description"] ?? "",
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
