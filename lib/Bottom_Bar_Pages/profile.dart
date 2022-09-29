// ignore_for_file: prefer_const_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final String name;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    CollectionReference database =
        FirebaseFirestore.instance.collection('Data');
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<DocumentSnapshot>(
        future: database.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Center(
                            child: Image.asset(
                          'assets/pro.gif',
                          // height: 500.0,
                          // width: 200.0,
                        )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    height: 200.0,
                    color: Color.fromARGB(255, 115, 3, 192),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("Name: ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              Text(data['username'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("NIC: ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              Text(data['id'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("Vehicle Number: ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              Text(data['vnum'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("Email: ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              Text(data['email'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Text("loading");
        },
      ),
    );
  }
}
