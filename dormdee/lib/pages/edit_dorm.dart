import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/utilities/dropdown_upload_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/text_field.dart';

class EditDorm extends StatefulWidget {
  const EditDorm({
    super.key,
    required this.dormName,
    required this.dormAddress,
    required this.dormInformation,
    required this.dormPrice,
    required this.dormImageUrl,
    required this.dormCategory,
    required this.dormId,
    required this.dormContact,
  });
  final String dormName;
  final String dormAddress;
  final String dormInformation;
  final String dormPrice;
  final String dormImageUrl;
  final String dormCategory;
  final String dormId;
  final String dormContact;

  @override
  State<EditDorm> createState() => _EditDormState();
}

class _EditDormState extends State<EditDorm> {
  @override
  void initState() {
    DormController.instance.imageUrlRx.value = widget.dormImageUrl;
    DormController.instance.name.text = widget.dormName;
    DormController.instance.address.text = widget.dormAddress;
    DormController.instance.information.text = widget.dormInformation;
    DormController.instance.price.text = widget.dormPrice;
    DormController.instance.category.text = widget.dormCategory;
    DormController.instance.contact.text = widget.dormContact;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Dormitory"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    final imageUrl =
                        await DormController.instance.uploadDormImage();
                    DormController.instance.imageUrl = imageUrl;
                  } catch (e) {
                    throw "Something went wrong $e";
                  }
                },
                child: Obx(() {
                  return DormController.instance.imageUrlRx.value == ""
                      ? const CircleAvatar(
                          radius: 100,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50.0,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            DormController.instance.imageUrlRx.value,
                            fit: BoxFit.fill,
                            width: 160,
                            height: 160,
                          ),
                        );
                }),
              ),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                  controller: DormController.instance.name, title: "Dorm Name"),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller: DormController.instance.address,
                  title: "Address"),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller: DormController.instance.information,
                  title: "Information"),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller: DormController.instance.price, title: "Price"),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller: DormController.instance.contact,
                  title: "Contact"),
              const SizedBox(height: 20),
              const DropDownUpload(),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(50, 40),
                      backgroundColor: const Color.fromARGB(221, 51, 169, 59)),
                  onPressed: () {
                    Get.defaultDialog(
                        backgroundColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20.0),
                        title: "Ed Dorms",
                        titleStyle: const TextStyle(color: Colors.black),
                        titlePadding: const EdgeInsets.only(top: 20.0),
                        middleText:
                            "Are you sure you want to change dorms info?",
                        content: const Column(children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Color.fromARGB(221, 54, 111, 255),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text("Are you sure you want to change dorms info?")
                        ]),
                        onCancel: () {
                          Get.back();
                        },
                        cancelTextColor: Colors.black,
                        cancel: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color.fromARGB(221, 54, 111, 255)),
                              minimumSize: const Size(50, 40),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Cancel",
                              style: TextStyle(
                                color: Color.fromARGB(221, 54, 111, 255),
                              )),
                        ),
                        confirm: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(50, 40),
                                backgroundColor:
                                    const Color.fromARGB(221, 54, 111, 255)),
                            onPressed: () {
                              DormController.instance
                                  .updateDormInfo(widget.dormId);
                              Get.back();
                              // Navigator.pop(context);
                            },
                            child: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.white),
                            )),
                        barrierDismissible: false);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
