import 'package:flutter/material.dart';
import 'package:dormdee/models/dorm_model.dart';

class DormDetail extends StatefulWidget {
  const DormDetail({Key? key}) : super(key: key);

  @override
  State<DormDetail> createState() => DormDetailState();
}

class DormDetailState extends State<DormDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              "images/dormdeelogo.png",
              scale: 10,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dorm Name",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              const Text("Dorm Rating",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              const Text("Dorm Address",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(60, 40)),
                  onPressed: () {},
                  child: const Text("View Details"))
            ],
          )
        ]),
      ),
    );
  }
}
