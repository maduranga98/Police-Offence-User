// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, avoid_unnecessary_containers, camel_case_types, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestingRange extends StatefulWidget {
  const TestingRange({super.key});

  @override
  State<TestingRange> createState() => _TestingRangeState();
}

class count {
  final DateTime week;
  final int amount;
  count(this.week, this.amount);
}

class _TestingRangeState extends State<TestingRange> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    List<count> week = [];
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Data")
            .doc(uid)
            .collection("fine")
            .where('mode', isEqualTo: 'notpaid')
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          var ds = snapshot.data!.docs;
          for (int i = 0; i < ds.length; i++) {
            DateTime today = ds[i]['date'].toDate();
            DateTime _firstDayOfTheweek =
                today.subtract(Duration(days: today.weekday));
            DateTime _lastDayOfTheweek =
                today.subtract(Duration(days: today.weekday - 1));
            var myListFiltered =
                week.where((e) => e.week == _firstDayOfTheweek);

            print(_firstDayOfTheweek.day);
            print(_lastDayOfTheweek.day);
          }
          // DateTime today = DateTime.now();

          // DateTime _lastDayOfTheweek =
          //     today.subtract(Duration(days: today.weekday - 1));
          // print(_firstDayOfTheweek.day);
          // print(_lastDayOfTheweek.day);
          return Container(
            child: Center(
                child: Column(
              children: [
                // Text(_firstDayOfTheweek.day.toString()),
                // Text(_lastDayOfTheweek.day.toString()),
              ],
            )),
          );
        }),
      ),
    );
  }
}
