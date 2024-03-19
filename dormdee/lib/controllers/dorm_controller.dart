import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/firebase_service/firebase_storage_service.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:dormdee/models/rating_model.dart';
import 'package:dormdee/pages/home_page.dart';
import 'package:dormdee/utilities/error_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class DormController extends GetxController {
  static DormController get instance => Get.find();
  final _filteredDormsController =
      StreamController<List<DormModel>>.broadcast();
  Stream<List<DormModel>> get filteredDormsStream =>
      _filteredDormsController.stream;

  final fs = FirebaseFirestore.instance;
  RxBool dormLoading = false.obs;
  RxList<DormModel> dorms = <DormModel>[].obs;
  RxList<RatingModel> ratingsRx = <RatingModel>[].obs;
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController information = TextEditingController();
  TextEditingController price = TextEditingController();
  String imageUrl = "";
  RxString imageUrlRx = "".obs;
  TextEditingController category = TextEditingController();
  TextEditingController contact = TextEditingController();
  RxList<DormModel> topRatedDorms = <DormModel>[].obs;
  RxList<DormModel> filteredDorms = <DormModel>[].obs;
  RxList<DormModel> favoriteDorms = <DormModel>[].obs;
  RxList<String> favoriteDormIds = <String>[].obs;
  var dropdownValue = "All".obs;
  void toggleFavorite(int index) {
    dorms[index].isFavorite = !dorms[index].isFavorite;
    update();
  }

  void updateFilteredDorms(List<DormModel> newDorms) {
    filteredDorms.assignAll(newDorms);
  }

  void updateFavoriteDorms(List<DormModel> newDorms) {
    favoriteDorms.assignAll(newDorms);
  }

  Future<void> deleteFavoriteDorm(String documentId, String dormId) async {
    try {
      // ระบุ collection ที่เก็บข้อมูล favorite dorms
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      // ลบ dorm ที่ระบุออกจากรายการโปรด
      await _firestore.collection('users').doc(documentId).update({
        "favdorm": FieldValue.arrayRemove([dormId]),
      });
      print('Favorite dorm deleted successfully ${dormId}');
      // ลบข้อมูล dorm ออกจาก collection
      // QuerySnapshot querySnapshot = await _firestore
      //     .collection('users')
      //     .where('favdorm', isEqualTo: dorms[index].id)
      //     .get();
      // querySnapshot.docs[0].reference.delete();
    } catch (e) {
      debugPrint('Error deleting favorite dorm: $e');
    }
  }

  Future<void> addFavoriteDorm(documentId, int index) async {
    try {
      // ระบุ collection ที่เก็บข้อมูล favorite dorms
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      await _firestore.collection('users').doc(documentId).update({
        "favdorm": FieldValue.arrayUnion([dorms[index].id]),
      });

      print('Favorite dorm added successfully');
    } catch (e) {
      print('Error adding favorite dorm: $e');
    }
  }

  @override
  void onInit() {
    fetchDorms().then((_) => filterDorms("All"));
    super.onInit();
    filterDorms('All');
    loadFavDorm();
  }

  void filterDorms(String category) {
    dropdownValue.value = category;
    if (category == 'All') {
      filteredDorms.assignAll(dorms);
    } else {
      filteredDorms.assignAll(
        dorms.where((dorm) => dorm.category == category).toList(),
      );
    }
  }

  RxList<DormModel> getFilteredDorms() {
    return RxList<DormModel>.from(filteredDorms);
  }

  Future<void> fetchDorms() async {
    try {
      // dormLoading.value = true;
      final dorm = await getDorms();
      dorms.assignAll(dorm);
      final topRated = dorm.toList()
        ..sort((a, b) => b.rating.compareTo(a.rating));
      topRatedDorms.assignAll(topRated.take(5));
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    } finally {
      dormLoading.value = false;
    }
  }

  Future<void> fetchRatings(String id) async {
    try {
      final rating = await getRatings(id);
      ratingsRx.assignAll(rating);
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  Stream<DormModel> streamDorm(String dormId) {
    return FirebaseFirestore.instance
        .collection('dorms')
        .doc(dormId)
        .snapshots()
        .map((doc) {
      return DormModel.fromSnapshot(doc);
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> loadFavDorm() async {
    try {
      String userId = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      List<String> favDormIds = List<String>.from(userDoc.get('favdorm'));

      List<Future<DormModel>> futureDorms = favDormIds.map((dormId) {
        return _firestore.collection('dorms').doc(dormId).get().then((doc) {
          return DormModel.fromMap(
              doc.data()!); // Assuming you have a fromMap method in DormModel
        });
      }).toList();

      List<DormModel> loadedDorms = await Future.wait(futureDorms);

      favoriteDormIds.assignAll(favDormIds);
      favoriteDorms.assignAll(loadedDorms);
    } catch (error) {
      print('Error loading favorite dorms: $error');
    }
  }

  Future<List<DormModel>> getDorms() async {
    try {
      final snapshot = await fs
          .collection("dorms")
          .orderBy("createdAt", descending: true)
          .get();

      final list =
          snapshot.docs.map((docs) => DormModel.fromSnapshot(docs)).toList();

      return list;
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
      return [];
    }
  }

  void updateDormInfo(String dormId) async {
    try {
      await FirebaseFirestore.instance.collection("dorms").doc(dormId).update({
        "name": name.text.trim(),
        "address": address.text.trim(),
        "information": information.text.trim(),
        "price": price.text.trim(),
        "category": category.text.trim(),
        "contact": contact.text.trim(),
        "imageUrl": imageUrlRx.value,
      });
      clearTextField();
      Get.back();
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getFavoriteDorms(String userId) async {
    try {
      // เรียกข้อมูลจาก Document ของ user ด้วย ID ของผู้ใช้
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      // ถ้ามี Document ของผู้ใช้อยู่จริง
      if (userDoc.exists) {
        // ดึงข้อมูล favdorm ออกมาจาก Document
        List<dynamic> favDorm = userDoc.get('favdorm');

        print('Favorite dorms retrieved successfully $favDorm');
        return favDorm;
      } else {
        // ถ้าไม่พบ Document ของผู้ใช้ หรือไม่มีข้อมูล favdorm
        print(
            'Document for user $userId does not exist or favdorm data is missing');
        return [];
      }
    } catch (e) {
      print('Error getting favorite dorms: $e');
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
    Get.to(() => HomePage());
  }

  Future<void> addDorm(DormModel dorm) async {
    try {
      DocumentReference ref = await fs.collection("dorms").add(dorm.toJson());
      dorm.id = ref.id;
      await fs.collection("dorms").add(dorm.toJson());
      fetchDorms();
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  Future<void> deleteDorm(String id) async {
    try {
      await fs.collection("dorms").doc(id).delete();
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
      double avgRating =
          ratings.map((m) => m['rating']).reduce((a, b) => a + b) /
              ratings.length;
      await fs.collection("dorms").doc(id).update({
        "rating": avgRating,
      });
      ratingsRx.assignAll(ratings.map((m) => RatingModel.fromMap(m)).toList());
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

  void clearTextField() {
    name.clear();
    address.clear();
    information.clear();
    price.clear();
    imageUrl = "";
    imageUrlRx.value = "";
    category.clear();
    contact.clear();
  }
}
