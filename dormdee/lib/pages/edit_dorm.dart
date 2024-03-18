import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/utilities/dorpdown_menu.dart';
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
  });
  final String dormName;
  final String dormAddress;
  final String dormInformation;
  final String dormPrice;
  final String dormImageUrl;
  final String dormCategory;

  @override
  State<EditDorm> createState() => _EditDormState();
}

class _EditDormState extends State<EditDorm> {
  @override
  void initState() {
    DormController.instance.imageUrlRx.value = widget.dormImageUrl;
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
                            widget.dormImageUrl,
                            fit: BoxFit.fill,
                            width: 200,
                            height: 200,
                          ),
                        );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller: TextEditingController(text: widget.dormName),
                  title: "Dorm Name"),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller: TextEditingController(text: widget.dormAddress),
                  title: "Address"),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller:
                      TextEditingController(text: widget.dormInformation),
                  title: "Information"),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                  controller: TextEditingController(text: widget.dormPrice),
                  title: "Price"),
              const SizedBox(
                height: 20,
              ),
              const DropDownMenu(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    DormController.instance
                        .uploadDorm(DormController.instance.imageUrl);
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
