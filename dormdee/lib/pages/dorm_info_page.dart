import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/models/rating_model.dart';

import 'package:dormdee/utilities/rating_bart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:dormdee/utilities/image_slider.dart';
import 'package:get/get.dart';

class DormInfoPage extends StatefulWidget {
  DormInfoPage({Key? key, required this.dorm, required this.dormId})
      : super(key: key);

  final DormModel dorm;
  final String dormId;
  final dormController = Get.put(DormController());

  @override
  State<DormInfoPage> createState() => _DormInfoPageState();
}

class _DormInfoPageState extends State<DormInfoPage> {
  int rating = 4;
  TextEditingController descriptionController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.dorm.name),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'How many stars would you like to give to ${widget.dorm.name}?',
                          style: const TextStyle(fontSize: 15),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBarApp(rating: rating, itemSize: 30),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(30),
                                  hintText: 'Description...',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                debugPrint(
                                    DormController().ratingsRx.toString());

                                debugPrint(rating.toString());

                                DocumentSnapshot userDoc =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(currentUser!.uid)
                                        .get();

                                final ratedDorm = RatingModel(
                                  rating: rating,
                                  description: descriptionController.text,
                                  userImage: userDoc.get("profilePicture"),
                                  user: userDoc.get("userName"),
                                  userId: currentUser!.uid,
                                  createdAt: DateTime.now(),
                                );
                                DormController.instance
                                    .rateDorm(widget.dormId, ratedDorm);
                              },
                              child: const Text("Submit")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.star_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            ImageSlider(
              imageUrl: widget.dorm.imageUrl,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                color: Colors.white70,
                surfaceTintColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Information",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.dorm.information),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('Month: ${widget.dorm.price} Baht'),
                  const Text(
                    "Rating",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(widget.dorm.rating.toString()),
                  const Text(
                    "Zone",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(widget.dorm.category),
                  const Text(
                    "Contact",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(widget.dorm.contact),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Comments",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              widget.dormController.ratingsRx.length,
                              (index) => Row(children: [
                                    widget.dormController.ratingsRx[index]
                                                .userImage !=
                                            ""
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(widget
                                                .dormController
                                                .ratingsRx[index]
                                                .userImage),
                                          )
                                        : const CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(widget.dormController
                                              .ratingsRx[index].user),
                                          Text(widget.dormController
                                              .ratingsRx[index].description),
                                        ],
                                      ),
                                    ),
                                  ])),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
