import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/firebase_service/firebase_storage_service.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:dormdee/models/rating_model.dart';
import 'package:dormdee/pages/home_page.dart';
import 'package:dormdee/utilities/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dormdee/firebase_service/firebase_store.dart';
class DormController extends GetxController {
  static DormController get instance => Get.find();
  final FirebaseFirestore fs = FirebaseFirestore.instance;
  RxList<String> favoriteDorms = <String>[].obs;

  RxList<DormModel> dorms = <DormModel>[].obs;
  RxList<RatingModel> ratings = <RatingModel>[].obs;
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController information = TextEditingController();
  TextEditingController price = TextEditingController();
  String imageUrl = "";
  RxString imageUrlRx = "".obs;
  TextEditingController category = TextEditingController();
  TextEditingController contact = TextEditingController();

  Future<void> fetchFavoriteDorms() async {
    try {
      final favorite = await getFavoriteDorms();
      favoriteDorms.assignAll(favorite);
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  } 

  Future<void> fetchDorms() async {
    try {
      final dorm = await getDorms();
      dorms.assignAll(dorm);
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  Future<void> fetchRatings(String id) async {
    try {
      final rating = await getRatings(id);
      ratings.assignAll(rating);
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  Future<List<String>> getFavoriteDorms() async {
    try {
      final snapshot = await fs.collection("users").doc("favorites").get();
      final list = snapshot.get("dorms").map((docs) => docs.toString()).toList();
      return list;
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
      return [];
    }
  }

  Future<List<DormModel>> getDorms() async {
    try {
      final snapshot = await fs.collection("dorms").get();
      final list =
          snapshot.docs.map((docs) => DormModel.fromSnapshot(docs)).toList();
      return list;
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
      return [];
    }
  }

  Future<List<RatingModel>> getRatings(String id) async {
    try {
      final snapshot = await fs.collection("dorms").doc(id).get();
      final list = snapshot.get("ratings").map((docs) {
        return RatingModel.fromMap(docs);
      }).toList();
      return list;
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
      return [];
    }
  }
  Future<void> addFavoriteDorm(String id) async {
    try {
      await fs.collection("users").doc("favorites").update({
        "dorms": FieldValue.arrayUnion([id]),
      });
      fetchFavoriteDorms();
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  Future<void> uploadDorm(String imageUrl) async {
    final dorm = DormModel(
      name: name.text,
      address: address.text,
      information: information.text,
      price: price.text,
      imageUrl: imageUrl,
      rating: 0,
      category: category.text,
      contact: contact.text,
      createdAt: DateTime.now(),
      ratings: [],
      id: "",
    );
    addDorm(dorm);
    Get.to(() => const HomePage());
  }

  Future<void> addDorm(DormModel dorm) async {
    try {
      DocumentReference ref = await fs.collection("dorms").add(dorm.toJson());
      dorm.id = ref.id;
      await fs.collection("dorms").doc(dorm.id).update(dorm.toJson());
      fetchDorms();
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  Future<void> rateDorm(String id, RatingModel rating) async {
    try {
      await fs.collection("dorms").doc(id).update({
        "ratings": FieldValue.arrayUnion([rating.toJson()]),
      });
      DocumentSnapshot dormDoc = await fs.collection("dorms").doc(id).get();
      List ratings = dormDoc.get("ratings");
      double avgRating = ratings.fold(
          0, (prev, cur) => (prev + cur["rating"]) / ratings.length);
      await fs.collection("dorms").doc(id).update({
        "rating": avgRating,
      });
      fetchDorms();
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  uploadDormImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 400,
        maxHeight: 400);
    if (image != null) {
      final url =
          await FirebaseStorageService().uploadImage("dorms/images/", image);
      imageUrl = url;
      imageUrlRx.value = url;
      return imageUrl;
    }
  }
  
}

  
