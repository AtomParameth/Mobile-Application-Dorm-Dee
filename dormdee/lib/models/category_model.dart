import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String title;
  String imageUrl;
  bool isFiltered;

  CategoryModel({
    required this.title,
    required this.imageUrl,
    this.isFiltered = false,
  });

  static CategoryModel empty() {
    return CategoryModel(
      title: "",
      imageUrl: "",
      isFiltered: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "imageUrl": imageUrl,
      "isFiltered": isFiltered,
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return CategoryModel.empty();
    } else {
      final data = document.data()!;
      return CategoryModel(
        title: data["title"] ?? "",
        imageUrl: data["imageUrl"] ?? "",
        isFiltered: data["isFiltered"] ?? false,
      );
    }
  }
}
