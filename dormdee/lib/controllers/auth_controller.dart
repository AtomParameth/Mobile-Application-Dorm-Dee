import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/pages/profile_page.dart';
import 'package:dormdee/utilities/error_snackbar.dart';
import 'package:dormdee/utilities/show_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<User?> firebaseUser = Rx<User?>(FirebaseAuth.instance.currentUser);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  RxBool hidePassword = true.obs;

  void signUp() async {
    try {
      if (passwordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        showLoading();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then((value) {
          String userId = value.user!.uid;
          addUser(
              userId,
              emailController.text.trim(),
              phoneNumberController.text.trim(),
              userNameController.text.trim());
        });
        clearTextField();
        Get.back();
      } else {
        showErrorSnackbar("Error", "Password does not match!");
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      showErrorSnackbar("Error", e.message.toString());
    } finally {
      clearTextField();
    }
  }

  void signIn() async {
    try {
      showLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      clearTextField();
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.back();
      showErrorSnackbar("Error", e.message.toString());
    } finally {
      clearTextField();
    }
  }

  void addUser(
      String userId, String email, String phoneNumber, String userName) {
    FirebaseFirestore.instance.collection("users").doc(userId).set(
      {
        "uid": userId,
        "email": email,
        "phone_number": phoneNumber,
        "username": userName,
      },
    );
  }

  void updateUserInfo() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.value!.uid)
          .update({
        "phone_number": phoneNumberController.text.trim(),
        "username": userNameController.text.trim(),
      });
      Get.to(() => const ProfilePage());
    } on FirebaseException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    }
  }

  void clearTextField() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneNumberController.clear();
    userNameController.clear();
  }
}
