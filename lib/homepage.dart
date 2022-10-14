// ignore_for_file: prefer_const_constructors, unused_import, unused_field, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_offence_user/Drawer_Pages/aboutus.dart';
import 'package:police_offence_user/Drawer_Pages/contactus.dart';
import 'package:police_offence_user/Bottom_Bar_Pages/home.dart';
import 'package:police_offence_user/Drawer_Pages/report.dart';
import 'package:police_offence_user/First_Screens/loginPage.dart';
import 'package:police_offence_user/Bottom_Bar_Pages/profile.dart';
import 'package:police_offence_user/Bottom_Bar_Pages/historyPage.dart';
import 'package:police_offence_user/Maps/Map.dart';
import 'package:police_offence_user/Sub_Pages/vediopayer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    Home(),
    historypage(),
    Profile(),
  ];
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 30),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 115, 3, 192),
        centerTitle: true,
        title: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              " Police",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 236, 56, 188)),
            ),
            Text(
              "Offence",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 253, 239, 249)),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        " Police",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 167, 209, 41)),
                      ),
                      Text(
                        "Offence",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 97, 111, 57)),
                      ),
                    ],
                  ),
                  Text(
                    email.toString(),
                    style: TextStyle(color: Color.fromARGB(255, 62, 67, 46)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 167, 209, 41),
              ),
              title: const Text(
                'Find Location',
                style: TextStyle(color: Color.fromARGB(255, 167, 209, 41)),
              ),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MapScreen5()));

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Maps()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                Icons.report,
                color: Color.fromARGB(255, 167, 209, 41),
              ),
              title: const Text(
                'Report',
                style: TextStyle(color: Color.fromARGB(255, 167, 209, 41)),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Report()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                Icons.contact_support,
                color: Color.fromARGB(255, 167, 209, 41),
              ),
              title: const Text('Contact Us',
                  style: TextStyle(color: Color.fromARGB(255, 167, 209, 41))),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => contactus()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                Icons.error,
                color: Color.fromARGB(255, 167, 209, 41),
              ),
              title: const Text('About Us',
                  style: TextStyle(color: Color.fromARGB(255, 167, 209, 41))),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => aboutus()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Color.fromARGB(255, 167, 209, 41),
              ),
              title: const Text('signout',
                  style: TextStyle(color: Color.fromARGB(255, 167, 209, 41))),
              onTap: () async {
                await auth.signOut();
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => Loginpage()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 115, 3, 192),
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color.fromARGB(255, 253, 239, 249)),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 253, 239, 249)),
          BottomNavigationBarItem(
              icon: Icon(Icons.history,
                  color: Color.fromARGB(255, 253, 239, 249)),
              label: 'History',
              backgroundColor: Color.fromARGB(255, 253, 239, 249)),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 253, 239, 249)),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 253, 239, 249),
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
