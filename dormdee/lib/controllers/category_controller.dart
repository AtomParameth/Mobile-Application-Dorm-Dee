import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/models/category_model.dart';
import 'package:dormdee/utilities/error_snackbar.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final fs = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      final category = await getAllCategories();
      categories.assignAll(category.where((element) => element.isFiltered));
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await fs.collection("categories").get();
      final list = snapshot.docs
          .map((docs) => CategoryModel.fromSnapshot(docs))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
      return [];
    }
  }
}
