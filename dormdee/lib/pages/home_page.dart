import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/profile_page.dart';
import 'package:dormdee/pages/upload_dorm.dart';
import 'package:flutter/material.dart';
import 'package:dormdee/utilities/search_bar.dart';
import 'package:dormdee/utilities/image_slider.dart';
import 'package:dormdee/utilities/dorm_card.dart';
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

  static final List<Widget> _widgetOptions = <Widget>[
    buildBody(),
    const Text(
      'No favorites dormitory is added',
    ),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: (selectedIndex == 0)
            ? AppBar(
                title: const SearchBarApp(),
                backgroundColor: Colors.black87,
              )
            : null,
        floatingActionButton: (selectedIndex == 0 || selectedIndex == 1)
            ? FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.blueAccent,
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
              icon: Icon(Icons.bookmark),
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
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
      ),
    );
  }

  static Widget buildBody() {
    return ListView(
      children: const [
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 40),
            Text(
              "Top Rated",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 20),
        ImageSlider(
          imageUrl:
              "https://studocu.com/blog/wp-content/uploads/2020/09/slovenia.jpg",
        ),
        DormCard(),
      ],
    );
  }
}
