import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPWPage extends StatefulWidget {
  const ForgetPWPage({super.key});

  @override
  State<ForgetPWPage> createState() => _ForgetPWPageState();
}

class _ForgetPWPageState extends State<ForgetPWPage> {
  final TextEditingController emailController = TextEditingController();
  bool contextUnderTF = true;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 140),
                  child: Image.asset("images/dormdeelogo.png"),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        labelText: "Enter your email...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 20, top: 20),
                  child: contextUnderTF
                      ? const Text(
                          "We’ll send the password reset info to your email address.",
                          style: TextStyle(fontSize: 10),
                        )
                      : const Text("We have sent it please check your email.",
                          style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 31, 169, 37))),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      onPressed: () async {
                        await resetPassword();
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 85, 122, 255),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      setState(() {
        contextUnderTF = !contextUnderTF;
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
