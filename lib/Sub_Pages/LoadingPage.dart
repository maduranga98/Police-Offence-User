// ignore_for_file: avoid_print, no_logic_in_create_state, must_be_immutable, file_names, non_constant_identifier_names, unused_element, prefer_const_constructors, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:police_offence_user/homepage.dart';

class Loading extends StatefulWidget {
  String Uid, docId;
  Loading({super.key, required this.Uid, required this.docId});

  @override
  State<Loading> createState() => _LoadingState(Uid: Uid, docId: docId);
}

class _LoadingState extends State<Loading> {
  String Uid, docId;
  _LoadingState({Key? key, required this.Uid, required this.docId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Colors.amber,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    onPressed: () {
                      print("Done");
                      FirebaseFirestore.instance
                          .collection("Data")
                          .doc(Uid)
                          .collection("fine")
                          .doc(docId)
                          .update({'limit': "updated", 'count': 1});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
