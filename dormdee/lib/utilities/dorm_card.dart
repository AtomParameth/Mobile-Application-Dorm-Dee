import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/dorm_info_page.dart';
import 'package:dormdee/utilities/rating_bart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DormCard extends StatefulWidget {
  const DormCard({Key? key}) : super(key: key);

  @override
  State<DormCard> createState() => DormCardState();
}

class DormCardState extends State<DormCard> {
  final dormController = Get.put(DormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Obx(
        () => Column(
          children: List.generate(
            dormController.dorms.length,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        dormController.dorms[index].imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dormController.dorms[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                          )),
                      RatingBarApp(
                        rating: dormController.dorms[index].rating.toInt(),
                        itemSize: 20,
                      ),
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
                                        dorm: dormController.dorms[index],
                                      )));
                        },
                        child: const Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      )
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
