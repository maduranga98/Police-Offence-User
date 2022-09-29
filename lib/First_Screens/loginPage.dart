// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unnecessary_new, sort_child_properties_last, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:police_offence_user/homepage.dart';
import 'package:police_offence_user/First_Screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  int activeIndex = 0;
  final GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 305),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 115, 3, 192)),
                  ),
                  Text(
                    " Police",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 236, 56, 188)),
                  ),
                  Text(
                    "Offence",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 115, 3, 192)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: Form(
                key: _userLoginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color.fromARGB(255, 253, 239, 249),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Email',
                        hintText: 'Email',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 253, 239, 249),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 253, 239, 249),
                          fontSize: 14.0,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 253, 239, 249),
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color.fromARGB(255, 253, 239, 249),
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 253, 239, 249),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: username,
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be blank' : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Color.fromARGB(255, 253, 239, 249),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Password',
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 253, 239, 249),
                          fontSize: 14.0,
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 253, 239, 249),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Icons.key,
                          color: Color.fromARGB(255, 253, 239, 249),
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color.fromARGB(255, 253, 239, 249),
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 253, 239, 249),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: password,
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be blank' : null,
                    ),
                  ],
                ),
              ),
            ),

            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () => {
                if (_userLoginFormKey.currentState!.validate())
                  {
                    auth.signInWithEmailAndPassword(
                        email: username.text.trim(),
                        password: password.text.trim()),
                    user == null ? Loginpage() : HomePage(),
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomePage())),
                    Fluttertoast.showToast(
                        msg: "Welcome Back to PoliceOffence",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 115, 3, 192),
                        textColor: Colors.white,
                        fontSize: 16.0)
                  }
              },
              height: 45,
              color: Colors.black,
              child: const Text(
                "SignIn",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const SignUp())),
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                        color: Color.fromARGB(255, 236, 56, 188),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
