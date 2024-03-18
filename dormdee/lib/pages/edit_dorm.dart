import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/dorm_info_page.dart';
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
    required this.dormId,
  });
  final String dormName;
  final String dormAddress;
  final String dormInformation;
  final String dormPrice;
  final String dormImageUrl;
  final String dormCategory;
  final String dormId;

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
              const DropDownMenu(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    DormController.instance.updateDormInfo(widget.dormId);
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
