import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/dorm_info_page.dart';
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = dormController.filteredDormsStream.listen((_) {
        dormController.update(); // Refresh UI when dorms changes
      });
    });
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
      padding: const EdgeInsets.symmetric(horizontal: 40),
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
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                        onPressed: () {
                          toggleFavorite(index);
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

// class DormCard extends StatefulWidget {
//   const DormCard({Key? key}) : super(key: key);

//   @override
//   State<DormCard> createState() => DormCardState();
// }

// class DormCardState extends State<DormCard> {
//   final dormController = Get.put(DormController());

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: MediaQuery.of(context).size.width,
//         height: 500,
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         child: SingleChildScrollView(
//           child: Obx(
//             () => ListView.builder(
//               shrinkWrap: true,
//               physics: const ClampingScrollPhysics(),
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 30,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color.fromARGB(67, 58, 58, 58),
//                         spreadRadius: 0.1,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       )
//                     ],
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40)),
//                           width: 100,
//                           height: 100,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Image.network(
//                               dormController.dorms[index].imageUrl,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(dormController.dorms[index].name,
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                 )),
//                             RatingBarApp(
//                               rating:
//                                   dormController.dorms[index].rating.toInt(),
//                               itemSize: 20,
//                             ),
//                             ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         const Color.fromARGB(255, 32, 32, 32),
//                                     minimumSize: const Size(40, 40)),
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => DormInfoPage(
//                                                 dorm:
//                                                     dormController.dorms[index],
//                                               )));
//                                 },
//                                 child: const Text(
//                                   "View Details",
//                                   style: TextStyle(
//                                       fontSize: 10, color: Colors.white),
//                                 ))
//                           ],
//                         )
//                       ]),
//                 );
//               },
//               itemCount: DormController.instance.dorms.length,
//             ),
//           ),
//         ));
//   }
// }


// class DormDetailState extends State<DormDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 180,
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.black87,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         width: MediaQuery.of(context).size.width,
//         child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//           SizedBox(
//             width: 100,
//             height: 100,
//             child: Image.asset(
//               "images/dormdeelogo.png",
//               scale: 10,
//               fit: BoxFit.fill,
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Dorm Name",
//                   style: TextStyle(
//                     color: Colors.white,
//                   )),
//               const Text("Dorm Rating",
//                   style: TextStyle(
//                     color: Colors.white,
//                   )),
//               const Text("Dorm Address",
//                   style: TextStyle(
//                     color: Colors.white,
//                   )),
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       minimumSize: const Size(60, 40)),
//                   onPressed: () {},
//                   child: const Text("View Details"))
//             ],
//           )
//         ]),
//       ),
//     );
//   }
// }
