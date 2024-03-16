import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dormdee/pages/dorm_info_page.dart';

class FavoritePage extends StatelessWidget {
  final DormController dormController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Dorms'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: dormController.dorms.length,
          itemBuilder: (context, index) {
            DormModel dorm = dormController.dorms[index];
            if (dorm.isFavorite) {
              return ListTile(
                title: Text(dorm.name),
                subtitle: Text('Rating: ${dorm.rating.toString()}'),
                leading: Image.network(
                  dorm.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DormInfoPage(
                                dorm: dormController.dorms[index],
                                dormId: dormController.dorms[index].id,
                              ),
                            ),
                          );
                        },

              );
            } else {
              // Return an empty container if the dorm is not a favorite
              return Container();
            }
          },
        ),
      ),
    );
  }
}