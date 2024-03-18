import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/models/user_model.dart';
import 'package:dormdee/utilities/error_snackbar.dart';
import 'package:dormdee/utilities/show_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              clientId:
                  "529712825170-9ora2lesp1ob77bbtg7oa02vem20eo46.apps.googleusercontent.com")
          .signIn();
      showLoading();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userCredential.user!.uid)
              .get();
      if (!userDoc.exists) {
        storeGoogleUser(userCredential);
      }
    } on FirebaseAuthException catch (e) {
      showErrorSnackbar("Error", e.message.toString());
    } finally {
      Get.back();
    }
  }

  void storeGoogleUser(UserCredential userCredential) async {
    if (userCredential.user != null) {
      final User user = userCredential.user!;
      final UserModel userModel = UserModel(
        id: user.uid,
        userName: user.displayName ?? "",
        email: user.email ?? "",
        phoneNumber: user.phoneNumber ?? "",
        profilePicture: user.photoURL ?? "",
        favdorm: [],
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(userModel.toJson());
    }
  }

  void addUser(
      String userId, String email, String phoneNumber, String userName) {
    final newUser = UserModel(
      id: userId,
      email: email,
      phoneNumber: phoneNumber,
      userName: userName,
      profilePicture: "",
      favdorm: [],
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(newUser.toJson());
  }

  void updateUserInfo() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "phoneNumber": phoneNumberController.text.trim(),
        "userName": userNameController.text.trim(),
      });
      clearTextField();
      Get.back();
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
