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
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Favorite Dorms'),
      ),
      body: Obx(
        () {
          DormController dormController = Get.find();
          List<String> favDorm = dormController.favoriteDormIds;
          List<DormModel> dorms = dormController.favoriteDorms;
          if (favDorm.isEmpty) {
            return const Center(
              child: Text(
                'No favorite dorms yet',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: dorms.length,
              itemBuilder: (context, index) {
                DormModel dorm = dorms[index];

                if (favDorm.contains(dorm.id)) {
                  return Dismissible(
                    background: Container(
                      color: const Color.fromARGB(255, 255, 98, 87),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      dormController.deleteFavoriteDorm(
                          FirebaseAuth.instance.currentUser!.uid, dorm.id);
                      dormController.loadFavDorm();
                      dormController.filteredDorms[index].isFavorite = false;
                    },
                    key: UniqueKey(),
                    child: ListTile(
                      title: Text(dorm.name),
                      subtitle: Text('Rating: ${dorm.rating.toString()}'),
                      leading: ClipOval(
                        child: Image.network(
                          dorm.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
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
                }
              },
            );
          }
        },
      ),
    );
  }
}
