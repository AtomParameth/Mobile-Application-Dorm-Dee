import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  const AppTextField(
      {super.key, required this.controller, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            contentPadding: const EdgeInsets.only(left: 20),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
