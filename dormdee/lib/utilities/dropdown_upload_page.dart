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
        ...<String>{'Lung Mor', 'Kangsadan', 'Non Muang'}
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          onTap: () {},
        );
      }).toList(),
    );
  }
}
