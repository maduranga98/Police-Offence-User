// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:police_offence_user/homepage.dart';
import 'package:police_offence_user/First_Screens/loginPage.dart';
import 'package:shimmer/shimmer.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 3, 0, 305),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100.0,
                child: ClipRRect(
                  child: Center(child: Image.asset('assets/img1.gif')),
                  borderRadius: BorderRadius.circular(80.0),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              // Image.asset('assets/img1.gif'),
              Center(
                  child: SizedBox(
                child: Shimmer.fromColors(
                    child: Text(
                      'PoliceOffence',
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    baseColor: Color.fromARGB(255, 115, 3, 192),
                    highlightColor: Color.fromARGB(255, 253, 239, 249)),
              )),
            ],
          ),
        ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return Loginpage();
          }
        },
      ),
    );
  }
}
