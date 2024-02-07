import 'package:cloud_firestore/cloud_firestore.dart';

class DormModel {
  final String name;
  final String address;
  final String information;
  final String price;
  final String imageUrl;
  final int rating;
  final String category;
  final String contact;

  DormModel({
    required this.name,
    required this.address,
    required this.information,
    required this.price,
    required this.imageUrl,
    this.rating = 0,
    this.category = "",
    this.contact = "",
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
        information: data["information"] ?? "",
        price: data["price"] ?? "",
        imageUrl: data["imageUrl"] ?? "",
        rating: data["rating"] ?? 0,
        category: data["category"] ?? "",
        contact: data["contact"] ?? "",
      );
    }
  }
}
