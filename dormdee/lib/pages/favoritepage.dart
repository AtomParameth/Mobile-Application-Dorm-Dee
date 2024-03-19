import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dormdee/pages/dorm_info_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

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
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    dormController.deleteFavoriteDorm(
                        FirebaseAuth.instance.currentUser!.uid, index);
                    dormController.loadFavDorm();
                  },
                  key: UniqueKey(),
                  child: ListTile(
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
                  ),
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
