import 'package:cloud_firestore/cloud_firestore.dart';

class DormModel {
  final String name;
  final String address;
  final String description;
  final String price;
  final String imageUrl;
  final int rating;

  DormModel({
    required this.name,
    required this.address,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 0,
  });

  static DormModel empty() {
    return DormModel(
      name: "",
      address: "",
      description: "",
      price: "",
      imageUrl: "",
      rating: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "description": description,
      "price": price,
      "imageUrl": imageUrl,
      "rating": rating,
    };
  }

  factory DormModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return DormModel.empty();
    } else {
      final data = document.data()!;
      return DormModel(
        name: data["name"] ?? "",
        address: data["address"] ?? "",
        description: data["description"] ?? "",
        price: data["price"] ?? "",
        imageUrl: data["imageUrl"] ?? "",
        rating: data["rating"] ?? 0,
      );
    }
  }
}
