import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/profile_page.dart';
import 'package:dormdee/pages/upload_dorm.dart';
import 'package:flutter/material.dart';
import 'package:dormdee/pages/In_home_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final dormController = Get.put(DormController());

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    InHomePage(),
    Text(
      'Index 1: Favorites Page',
    ),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (selectedIndex == 0 || selectedIndex == 1)
          ? FloatingActionButton(
              elevation: double.infinity,
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UploadDorm()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ))
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 11, 167, 240),
        onTap: onItemTapped,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
      ),
    );
  }
}
