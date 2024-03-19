import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/profile_page.dart';
import 'package:dormdee/pages/upload_dorm.dart';
import 'package:dormdee/utilities/dorpdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:dormdee/utilities/search_bar.dart';
import 'package:dormdee/utilities/image_slider.dart';
import 'package:dormdee/utilities/dorm_card.dart';
import 'package:get/get.dart';
import 'package:dormdee/pages/favoritepage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final dormController = Get.put(DormController());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    buildBody(),
    FavoritePage(),
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
                backgroundColor: Colors.black87,
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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: const Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 40),
                Text(
                  "Top Rated",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ImageSlider(),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 45), child: DropDownMenu()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            DormCard(),
          ],
        ),
      ),
    );
  }
}
