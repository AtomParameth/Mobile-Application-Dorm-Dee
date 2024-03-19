import 'package:dormdee/controllers/auth_controller.dart';
import 'package:dormdee/utilities/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String phoneNumber;
  final String imageUrl;
  const EditProfilePage(
      {super.key,
      required this.userName,
      required this.phoneNumber,
      required this.imageUrl});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    AuthController.instance.userNameController.text = widget.userName;
    AuthController.instance.phoneNumberController.text = widget.phoneNumber;
    AuthController.instance.imageUrlRx.value = widget.imageUrl;
    super.initState();
  }

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
              GestureDetector(
                onTap: () async {
                  try {
                    final imageUrl =
                        await AuthController.instance.uploadProfileImage();
                    AuthController.instance.imageUrl = imageUrl;
                  } catch (e) {}
                },
                child: Obx(() {
                  return AuthController.instance.imageUrlRx.value == ""
                      ? const CircleAvatar(
                          radius: 100,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50.0,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            AuthController.instance.imageUrlRx.value,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        );
                }),
              ),
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
                  Get.defaultDialog(
                      contentPadding: const EdgeInsets.all(20.0),
                      title: "Edit Profile",
                      titleStyle: const TextStyle(color: Colors.black),
                      titlePadding: const EdgeInsets.only(top: 20.0),
                      middleText: "Are you sure you want to save changes?",
                      content: const Column(children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Color.fromARGB(221, 51, 169, 59),
                          child: Icon(
                            Icons.question_mark_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text("Are you sure you want to save changes?")
                      ]),
                      onCancel: () {
                        Get.back();
                      },
                      cancelTextColor: Colors.black,
                      cancel: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: Color.fromARGB(221, 51, 169, 59)),
                            minimumSize: const Size(50, 40),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                              color: Color.fromARGB(221, 51, 169, 59),
                            )),
                      ),
                      confirm: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(50, 40),
                              backgroundColor:
                                  const Color.fromARGB(221, 51, 169, 59)),
                          onPressed: () {
                            AuthController.instance.updateUserInfo();
                            Get.back();
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          )),
                      barrierDismissible: false);
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
