import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DormDetail extends StatefulWidget {
  const DormDetail({Key? key}) : super(key: key);

  @override
  State<DormDetail> createState() => DormDetailState();
}

class DormDetailState extends State<DormDetail> {
  final dormController = Get.put(DormController());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Obx(
          () => ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    DormController.instance.dorms[index].imageUrl,
                    scale: 10,
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  DormController.instance.dorms[index].name,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  DormController.instance.dorms[index].rating.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(60, 40),
                  ),
                  onPressed: () {},
                  child: const Text("View Details"),
                ),
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
