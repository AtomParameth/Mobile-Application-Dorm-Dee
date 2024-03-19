import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:flutter/material.dart';

class DropDownUpload extends StatefulWidget {
  const DropDownUpload({Key? key}) : super(key: key);

  @override
  State<DropDownUpload> createState() => _DropDownUploadState();
}

class _DropDownUploadState extends State<DropDownUpload> {
  String dropdownValue = 'Lung Mor';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.white, // Change the color of the button
          borderRadius:
              BorderRadius.circular(20), // Change the shape of the button

          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(67, 58, 58, 58),
              spreadRadius: 0.1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(10),
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 0,
          style: const TextStyle(color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              DormController.instance.category.text = newValue!;
              dropdownValue = newValue;
            });
          },
          items: [
            ...<String>{'Lung Mor', 'Kangsadan', 'Non Muang'}
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
              onTap: () {
                setState(() {
                  DormController.instance.category.text = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
