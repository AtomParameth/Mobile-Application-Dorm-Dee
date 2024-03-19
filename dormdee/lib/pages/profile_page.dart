import 'package:dormdee/pages/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dormdee/controllers/auth_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authUser = FirebaseAuth.instance.currentUser;
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    if (authUser!.photoURL != null) {
      authController.imageUrlRx.value = authUser!.photoURL!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(authUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final userData = snapshot.data!.data() as Map<String, dynamic>;

                return Stack(children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 50.0),
                      CircleAvatar(
                        radius: 80,
                        child: userData["profilePicture"] == ""
                            ? const Icon(
                                Icons.person,
                                size: 80,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        userData["profilePicture"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(userData['userName'].toString(),
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 25,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 40),
                            backgroundColor: Colors.black87),
                        onPressed: () {
                          Get.to(() => EditProfilePage(
                                userName: userData['userName'].toString(),
                                phoneNumber: userData['phoneNumber'].toString(),
                                imageUrl: userData['profilePicture'].toString(),
                              ));
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(67, 58, 58, 58),
                              spreadRadius: 0.1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // ListTile(
                            //   leading: const Icon(Icons.person),
                            //   title: Text(userData['userName'].toString()),
                            // ),
                            // const Divider(),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: Text(userData['email'].toString()),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: Text(userData['phoneNumber'].toString()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]);
              },
            ),
            const SizedBox(height: 60.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  minimumSize: const Size(250, 50),
                  backgroundColor: const Color.fromARGB(255, 255, 101, 96)),
              onPressed: () {
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                authController.clearTextField();
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
