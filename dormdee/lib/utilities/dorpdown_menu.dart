import 'package:flutter/material.dart';
import 'package:dormdee/controllers/dorm_controller.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownValue = 'All';
  final dormController = DormController.instance;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 0,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: [
        ...<String>{'All', 'Lung Mor', 'Kangsadan', 'Non Muang'}
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          onTap: () {
            dormController.filterDorms(value);
          },
        );
      }).toList(),
    );
  }
}
