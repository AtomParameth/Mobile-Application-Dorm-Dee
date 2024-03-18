import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/models/rating_model.dart';

class DormModel {
  final String name;
  final String address;
  final String information;
  final String price;
  final String imageUrl;
  final double rating;
  final String category;
  final String contact;
  final DateTime createdAt;
  final List<RatingModel> ratings;
  bool isFavorite;
  String id;

  DormModel({
    required this.name,
    required this.address,
    required this.information,
    required this.price,
    required this.imageUrl,
    this.rating = 0,
    this.category = "",
    this.contact = "",
    this.isFavorite = false,
    required this.createdAt,
    this.ratings = const [],
    required this.id,
  });

  static DormModel empty() {
    return DormModel(
      name: "",
      address: "",
      information: "",
      price: "",
      imageUrl: "",
      rating: 0,
      category: "",
      contact: "",
      createdAt: DateTime.now(),
      ratings: [],
      id: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "information": information,
      "price": price,
      "imageUrl": imageUrl,
      "rating": rating,
      "category": category,
      "contact": contact,
      "createdAt": createdAt,
      "ratings": ratings.map((rating) => rating.toJson()).toList(),
      "id": id,
    };
  }
  factory DormModel.fromMap(Map<String, dynamic> data) {
    var ratingList = data["ratings"] as List?;
    List<RatingModel> ratings = ratingList != null
        ? ratingList.map((i) => RatingModel.fromMap(i)).toList()
        : [];
    return DormModel(
      name: data["name"] ?? "",
      address: data["address"] ?? "",
      information: data["information"] ?? "",
      price: data["price"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
      rating: (data["rating"] ?? 0).toDouble(),
      category: data["category"] ?? "",
      contact: data["contact"] ?? "",
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      id: data["id"] ?? "",
      ratings: ratings,
    );
  }
  
  factory DormModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return DormModel.empty();
    } else {
      final data = document.data()!;
      var ratingList = data["ratings"] as List?;
      List<RatingModel> ratings = ratingList != null
          ? ratingList.map((i) => RatingModel.fromMap(i)).toList()
          : [];

      return DormModel(
        name: data["name"] ?? "",
        address: data["address"] ?? "",
        information: data["information"] ?? "",
        price: data["price"] ?? "",
        imageUrl: data["imageUrl"] ?? "",
        rating: (data["rating"] ?? 0).toDouble(),
        category: data["category"] ?? "",
        contact: data["contact"] ?? "",
        createdAt:
            (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
        id: data["id"] ?? "",
        ratings: ratings,
      );
    }
  }
}
