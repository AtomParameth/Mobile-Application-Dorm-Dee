import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dormdee/pages/dorm_info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final DormController dormController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Dorms'),
      ),
      body: Obx(
        () {
          DormController dormController = Get.find();
          List<String> favDorm = dormController.favoriteDormIds;
          List<DormModel> dorms = dormController.favoriteDorms;
          return ListView.builder(
            itemCount: dorms.length,
            itemBuilder: (context, index) {
              DormModel dorm = dorms[index];
              if (favDorm.contains(dorm.id)) {
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
                          dorm: dorm,
                          dormId: dorm.id,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Text("No favorite dorms");
              }
            },
          );
        },
      ),
    );
  }
}
