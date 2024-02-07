import 'package:flutter/material.dart';
import 'package:dormdee/pages/upload_dorm.dart';
import 'package:dormdee/utilities/search_bar.dart';
import 'package:dormdee/utilities/image_slider.dart';
import 'package:dormdee/utilities/dorm_detail.dart';

class InHomePage extends StatefulWidget {
  const InHomePage({Key? key}) : super(key: key);

  @override
  State<InHomePage> createState() => InHomePageState();
}

class InHomePageState extends State<InHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarApp(),
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
          elevation: double.infinity,
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UploadDorm()));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: const Column(children: [
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              "Top Rated",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
          ],
        ),
        SizedBox(height: 20),
        ImageSlider(),
        SizedBox(height: 60),
        DormDetail()
      ]),
    );
  }
}
