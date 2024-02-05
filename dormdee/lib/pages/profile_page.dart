import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 350,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                const CircleAvatar(
                  radius: 80,
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      maximumSize: const Size(160, 50),
                      backgroundColor: Colors.black87),
                  onPressed: () {},
                  child: const ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                    title: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("KuyBond"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.email),
                  title: Text("KuyBond@gmail.com"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("12345678"),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 121, 116)),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
