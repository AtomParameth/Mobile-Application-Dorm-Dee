import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:dormdee/utilities/error_snackbar.dart';
import 'package:get/get.dart';

class DormController extends GetxController {
  static DormController get instance => Get.find();

  final fs = FirebaseFirestore.instance;
  RxList<DormModel> dorms = <DormModel>[].obs;

  @override
  void onInit() {
    fetchDorms();
    super.onInit();
  }

  Future<void> fetchDorms() async {
    try {
      final dorm = await getDorms();
      dorms.assignAll(dorm);
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
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

  Future<void> addDorm(DormModel dorm) async {
    try {
      await fs.collection("dorms").add(dorm.toJson());
      fetchDorms();
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }
}
