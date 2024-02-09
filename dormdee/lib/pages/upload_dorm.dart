import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/utilities/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadDorm extends StatelessWidget {
  const UploadDorm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Dormitory"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                          width: 200,
                          height: 200,
                        ),
                      );
              }),
            ),
            AppTextField(
                controller: DormController.instance.name, title: "Dorm Name"),
            AppTextField(
                controller: DormController.instance.address, title: "Address"),
            AppTextField(
                controller: DormController.instance.information,
                title: "Information"),
            AppTextField(
                controller: DormController.instance.price, title: "Price"),
            AppTextField(
                controller: DormController.instance.category,
                title: "Category"),
            ElevatedButton(
                onPressed: () {
                  DormController.instance
                      .uploadDorm(DormController.instance.imageUrl);
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
