import 'package:flutter/material.dart';

class UploadDorm extends StatelessWidget {
  const UploadDorm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Dormitory"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Upload Dorm page"),
          ],
        ),
      ),
    );
  }
}
