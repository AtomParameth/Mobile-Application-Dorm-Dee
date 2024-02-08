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
                  title: "Username"),
              AppTextField(
                  controller: AuthController.instance.phoneNumberController,
                  title: "Phone number"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 40),
                    backgroundColor: const Color.fromARGB(221, 51, 169, 59)),
                onPressed: () {
                  AuthController.instance.updateUserInfo();
                },
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  )
                ]),
              ),
            ])));
  }
}
