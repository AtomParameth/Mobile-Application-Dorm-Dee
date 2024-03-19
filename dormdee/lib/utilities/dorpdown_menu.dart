import 'package:flutter/material.dart';
import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:get/get.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  final dormController = DormController.instance;

  @override
  void initState() {
    dormController.filterDorms(dormController.dropdownValue.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 140,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                  color: Colors.white, // Change the color of the button
                  borderRadius: BorderRadius.circular(
                      20), // Change the shape of the button

                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(67, 58, 58, 58),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: DropdownButtonHideUnderline(
                // Hide the default underline of the DropdownButton
                child: DropdownButton<String>(
                  value: dormController.dropdownValue.value,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 20,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
                  onChanged: (String? newValue) {
                    setState(() {
                      dormController.dropdownValue.value = newValue!;
                    });
                  },
                  items: [
                    ...<String>{'All', 'Lung Mor', 'Kangsadan', 'Non Muang'}
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        setState(() {
                          dormController.filterDorms(value);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ]));
  }
}
