import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/dorm_info_page.dart';
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
        height: 500,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Obx(
          () => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)),
                        width: 100,
                        height: 100,
                        child: Image.network(
                          dormController.dorms[index].imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dormController.dorms[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                          Text(dormController.dorms[index].rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize: const Size(60, 40)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DormInfoPage(
                                              dorm: dormController.dorms[index],
                                            )));
                              },
                              child: const Text("View Details"))
                        ],
                      )
                    ]),
              );
            },
            itemCount: DormController.instance.dorms.length,
          ),
        ));
  }
}
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
