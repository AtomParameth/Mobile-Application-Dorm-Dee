// import 'package:flutter/material.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);
//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(
//             width: 350,
//             child: FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(authUser!.uid)
//                   .get(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 }

//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }

//                 final userData = snapshot.data!.data() as Map<String, dynamic>;

//                 return Column(
//                   children: [
//                     const SizedBox(height: 20.0),
//                     const CircleAvatar(
//                       radius: 80,
//                       child: Icon(
//                         Icons.person,
//                         size: 80,
//                       ),
//                     ),
//                     const SizedBox(height: 20.0),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(50, 40),
//                           backgroundColor: Colors.black87),
//                       onPressed: () {},
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.edit,
//                             color: Colors.white,
//                             size: 15,
//                           ),
//                           SizedBox(width: 10.0),
//                           Text(
//                             "Edit",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20.0),
//                     ListTile(
//                       leading: const Icon(Icons.person),
//                       title: Text(userData['username']),
//                     ),
//                     const Divider(),
//                     ListTile(
//                       leading: const Icon(Icons.email),
//                       title: Text(userData['email']),
//                     ),
//                     const Divider(),
//                     ListTile(
//                       leading: const Icon(Icons.phone),
//                       title: Text(userData['phone_number']),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(250, 50),
//                 backgroundColor: const Color.fromARGB(255, 255, 121, 116)),
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//             child: const Text(
//               "Sign Out",
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//     );
//   }
// }
