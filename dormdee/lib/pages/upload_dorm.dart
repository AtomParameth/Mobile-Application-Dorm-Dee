import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/utilities/dropdown_upload_page.dart';
import 'package:dormdee/utilities/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadDorm extends StatefulWidget {
  const UploadDorm({Key? key}) : super(key: key);

  @override
  State<UploadDorm> createState() => _UploadDormState();
}

class _UploadDormState extends State<UploadDorm> {
  @override
  void initState() {
    DormController.instance.imageUrlRx.value = "";
    DormController.instance.name.text = "";
    DormController.instance.address.text = "";
    DormController.instance.information.text = "";
    DormController.instance.price.text = "";
    DormController.instance.category.text = "";
    DormController.instance.contact.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Dormitory"),
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
                          radius: 80,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50.0,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            DormController.instance.imageUrlRx.value,
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
              const SizedBox(height: 20),
              AppTextField(
                  controller: DormController.instance.contact,
                  title: "Contact"),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35.0),
                child: Row(
                  children: [
                    DropDownUpload(),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(50, 40),
                      backgroundColor: const Color.fromARGB(221, 51, 169, 59)),
                  onPressed: () {
                    DormController.instance
                        .uploadDorm(DormController.instance.imageUrl);
                  },
                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
