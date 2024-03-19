import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/models/rating_model.dart';
import 'package:dormdee/pages/edit_dorm.dart';
import 'package:dormdee/utilities/image_slider_dormInfo.dart';
import 'package:dormdee/utilities/rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dormdee/models/dorm_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  RxBool hasRated = false.obs;
  double rating = 0;
  TextEditingController descriptionController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  void handleRatingChange(double newRating) {
    rating = newRating;
  }

  void checkRatedDorm() async {
    DocumentSnapshot dormDoc = await FirebaseFirestore.instance
        .collection('dorms')
        .doc(widget.dormId)
        .get();
    DormModel dorm = DormModel.fromSnapshot(
        dormDoc as DocumentSnapshot<Map<String, dynamic>>);
    hasRated.value =
        dorm.ratings.any((element) => element.userId == currentUser!.uid);
  }

  @override
  void initState() {
    checkRatedDorm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.dorm.name),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    backgroundColor: Colors.white,
                    contentPadding: const EdgeInsets.all(20.0),
                    title: "Delete Dorms",
                    titleStyle: const TextStyle(color: Colors.black),
                    titlePadding: const EdgeInsets.only(top: 20.0),
                    middleText: "Are you sure you want to delete dorms?",
                    content: const Column(children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(221, 255, 71, 54),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text("Are you sure you want to delete dorms?")
                    ]),
                    onCancel: () {
                      Get.back();
                    },
                    cancelTextColor: Colors.black,
                    cancel: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: Color.fromARGB(221, 255, 71, 54)),
                          minimumSize: const Size(50, 40),
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancel",
                          style: TextStyle(
                            color: Color.fromARGB(221, 255, 71, 54),
                          )),
                    ),
                    confirm: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 40),
                            backgroundColor:
                                const Color.fromARGB(221, 255, 71, 54)),
                        onPressed: () {
                          widget.dormController.deleteDorm(widget.dormId);
                          Get.back();
                          // Navigator.pop(context);
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        )),
                    barrierDismissible: false);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDorm(
                      dormName: widget.dorm.name,
                      dormAddress: widget.dorm.address,
                      dormInformation: widget.dorm.information,
                      dormPrice: widget.dorm.price,
                      dormImageUrl: widget.dorm.imageUrl,
                      dormCategory: widget.dorm.category,
                      dormId: widget.dormId,
                      dormContact: widget.dorm.contact,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
          Obx(() => hasRated.value
              ? const Icon(Icons.star, color: Colors.amber)
              : IconButton(
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
                                RatingBarApp(
                                  ratingScore: rating,
                                  onRatingChanged: handleRatingChange,
                                ),
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
                                    await DormController.instance
                                        .rateDorm(widget.dormId, ratedDorm);
                                    descriptionController.clear();
                                    handleRatingChange(0);

                                    checkRatedDorm();
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
                  icon: const Icon(Icons.star_border))),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("dorms")
                  .doc(widget.dormId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    color: const Color.fromARGB(255, 245, 245, 245),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ImageSliderDormInfo(imageUrl: data['imageUrl']),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            elevation: 5,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Information",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data["information"]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    const Text(
                                      "Price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Month: ${data["price"]} Baht'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    const Text(
                                      "Rating",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(data["rating"].toStringAsFixed(1)),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    const Text(
                                      "Zone",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data["category"]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    const Text(
                                      "Contact",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data["contact"]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Comments",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  child: StreamBuilder<DormModel>(
                                    stream: widget.dormController
                                        .streamDorm(widget.dormId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        DormModel dorm = snapshot.data!;
                                        return Column(
                                          children: List.generate(
                                            dorm.ratings.length,
                                            (index) => Row(
                                              children: [
                                                dorm.ratings[index].userImage !=
                                                        ""
                                                    ? CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(dorm
                                                                .ratings[index]
                                                                .userImage),
                                                      )
                                                    : const CircleAvatar(
                                                        child:
                                                            Icon(Icons.person),
                                                      ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 0,
                                                      vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(dorm
                                                              .ratings[index]
                                                              .user),
                                                          const SizedBox(
                                                              width: 10),
                                                          RatingBar.builder(
                                                            allowHalfRating:
                                                                true,
                                                            updateOnDrag: false,
                                                            itemSize: 15,
                                                            itemCount: 1,
                                                            ignoreGestures:
                                                                true,
                                                            initialRating: 1,
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (double
                                                                    value) {},
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                              "${dorm.ratings[index].rating.toDouble()}")
                                                        ],
                                                      ),
                                                      Text(dorm.ratings[index]
                                                          .description),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  )),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })),
    ));
  }
}
