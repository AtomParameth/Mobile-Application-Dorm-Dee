import 'package:dormdee/controllers/auth_controller.dart';
import 'package:dormdee/pages/forgot_password.dart';
import 'package:flutter/material.dart';
//import 'package:dormdee/firebase_service/firebase_auth_service.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up.dart';

class LoginAppPage extends StatefulWidget {
  const LoginAppPage({Key? key}) : super(key: key);

  @override
  LoginAppPageState createState() => LoginAppPageState();
}

class LoginAppPageState extends State<LoginAppPage> {
  //final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureTextToggler = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void enableObscureText() {
    setState(() {
      obscureTextToggler = !obscureTextToggler;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Image.asset(
                    "images/dormitory.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset("images/dormdeelogo.png"),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      controller: AuthController.instance.emailController,
                      decoration: const InputDecoration(
                        labelText: "Username...",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      obscureText: obscureTextToggler,
                      controller: AuthController.instance.passwordController,
                      decoration: InputDecoration(
                        labelText: "Password...",
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
                        suffixIcon: IconButton(
                            onPressed: () {
                              enableObscureText();
                            },
                            icon: obscureTextToggler
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ForgetPWPage(),
                            ),
                          );
                        },
                        child: _buildGreyText("Forgot Password?"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _buildButton("Login", Colors.white,
                    const Color.fromARGB(255, 40, 40, 40)),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      )),
                      SizedBox(width: 10),
                      Text("or"),
                      SizedBox(width: 10),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ))
                    ],
                  ),
                ),
                _buildButtonWithImage(
                    "Login with Google",
                    "images/google_icon.png",
                    Colors.white,
                    const Color.fromARGB(255, 40, 40, 40),
                    onPressed: AuthController.instance.googleSignIn),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    _buildGreyText("Don't have an account?"),
                    Builder(
                      builder: (context) => TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void signInMethod() async {
  //   String email = emailController.text.trim();
  //   String password = passwordController.text.trim();
  //   User? user =
  //       await _firebaseAuthService.signInWithEmailAndPassword(email, password);
  //   if (user != null) {
  //     print("Sign in successful");
  //   } else {
  //     print("Sign in failed");
  //   }
  // }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromARGB(255, 68, 68, 68),
      ),
    );
  }

  Widget _buildButton(String text, Color textColor, Color backgroundColor) {
    return ElevatedButton(
      onPressed: AuthController.instance.signIn,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(330, 50),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }

  Widget _buildButtonWithImage(
      String text, String imgAsset, Color textColor, Color backgroundColor,
      {Function()? onPressed}) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(330, 50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/google_icon.png",
                scale: 1.5,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ));
  }
}
