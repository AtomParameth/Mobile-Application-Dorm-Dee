import 'package:dormdee/controllers/auth_controller.dart';
import 'package:dormdee/utilities/text_field.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              AppTextField(
                  controller: AuthController.instance.userNameController,
                  title: "username"),
              AppTextField(
                  controller: AuthController.instance.phoneNumberController,
                  title: "phone number"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                    backgroundColor: const Color.fromARGB(255, 40, 163, 48)),
                onPressed: () {
                  AuthController.instance.updateUserInfo();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ])));
  }
}
