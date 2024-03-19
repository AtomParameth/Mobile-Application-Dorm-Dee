import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/dorm_info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class DormCard extends StatefulWidget {
  const DormCard({Key? key}) : super(key: key);

  @override
  State<DormCard> createState() => DormCardState();
}

class DormCardState extends State<DormCard> {
  final dormController = Get.put(DormController());
  late StreamSubscription _subscription;

  @override
  void initState() {
    dormController.fetchDorms().then(
        (value) => Future.microtask(() => dormController.filterDorms("All")));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = dormController.filteredDormsStream.listen((_) {
        dormController.update(); // Refresh UI when dorms changes
      });
    });
    dormController.loadFavDorm();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  // Function to toggle favorite status
  void toggleFavorite(int index) {
    setState(() {
      dormController.toggleFavorite(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: Obx(
        () => Column(
          children: List.generate(
            dormController.filteredDorms.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(67, 58, 58, 58),
                    spreadRadius: 0.1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        dormController.filteredDorms[index].imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dormController.filteredDorms[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                          )),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          Text(
                            dormController.filteredDorms[index].rating == 0.0
                                ? 'N/A'
                                : dormController
                                    .getFilteredDorms()[index]
                                    .rating
                                    .toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 32, 32, 32),
                            minimumSize: const Size(40, 40)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DormInfoPage(
                                dorm: dormController.filteredDorms[index],
                                dormId: dormController.filteredDorms[index].id,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: dormController.filteredDorms[index].isFavorite
                            ? const Icon(Icons.bookmark, color: Colors.amber)
                            : const Icon(
                                Icons.bookmark_border,
                              ),
                        onPressed: () {
                          toggleFavorite(index);
                          if (dormController.filteredDorms[index].isFavorite) {
                            dormController.addFavoriteDorm(
                                FirebaseAuth.instance.currentUser!.uid, index);
                            dormController.getFavoriteDorms(
                                FirebaseAuth.instance.currentUser!.uid);
                            dormController.loadFavDorm();
                          } else {
                            dormController.deleteFavoriteDorm(
                              FirebaseAuth.instance.currentUser!.uid,
                              DormController.instance.favoriteDormIds[index],
                            );
                            dormController.loadFavDorm();

                            // try {
                            //   dormController.deleteFavoriteDorm(
                            //     FirebaseAuth.instance.currentUser!.uid,
                            //     DormController.instance.favoriteDormIds[index],
                            //   );
                            //   dormController.loadFavDorm();
                            // } catch (e) {
                            //   // Handle the error here
                            //   print('Error occurred: $e');
                            // }
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
