// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names, avoid_print, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:police_offence_user/Sub_Pages/creditcard.dart';
import 'package:intl/intl.dart';
import 'package:police_offence_user/Sub_Pages/vediopayer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final email = user.email;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 305),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Data')
            .doc(uid)
            .collection('fine')
            .where('mode', isEqualTo: 'notpaid')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var ds = snapshot.data!.docs;
          List ids = [];
          List ia = [];
          for (int i = 0; i < ds.length; i++) {
            final Timestamp timestamp2 = ds[i]['date'] as Timestamp;
            final DateTime dateTime2 = timestamp2.toDate();
            final dateString2 = DateFormat("dd, MMM").format(dateTime2);
            final FirstDayOfTheWeek =
                dateTime2.subtract(Duration(days: dateTime2.weekday - 1));
            final LastDayOfTheWeek = dateTime2
                .add(Duration(days: DateTime.daysPerWeek - dateTime2.weekday));
            print("Date: $dateString2");
            print("First Day of The Week: $FirstDayOfTheWeek");
            print("Last Day Of The Week: $LastDayOfTheWeek");
            int NoOfDaysPerweek = 0;

            for (int j = 0; j < ds.length; j++) {
              final Timestamp timestamp = ds[j]['date'] as Timestamp;
              final DateTime dateTime = timestamp.toDate();

              if (dateTime.compareTo(FirstDayOfTheWeek) >= 0 &&
                  dateTime.compareTo(LastDayOfTheWeek) <= 0) {
                NoOfDaysPerweek++;
              }
            }
            print(NoOfDaysPerweek);
            if (NoOfDaysPerweek >= 3) {
              ids.add(ds[i].id);
              ia.add(i);
            }
          }

          if (ia.isNotEmpty) {
            print("IDS: ${ids[0]}");
            print("Is: ${ia[0]}");
            // print("Value: ${ds[ia[0]]['count']}");

            if (ds[ia[0]]['limit'] != "updated") {
              FirebaseFirestore.instance
                  .collection("Data")
                  .doc(uid)
                  .collection("fine")
                  .doc(ids[0])
                  .update({'limit': "exceed"});
            }

            for (int i = 1; i < ids.length; i++) {
              FirebaseFirestore.instance
                  .collection("Data")
                  .doc(uid)
                  .collection("fine")
                  .doc(ids[i])
                  .update({'limit': "updated"});
            }
          }

          return ListView(
            children: snapshot.data!.docs.map((e) {
              final now = DateTime.now();
              final expirationDate = e['expired'].toDate();
              final bool isExpired = expirationDate.isBefore(now);
              if (isExpired) {
                FirebaseFirestore.instance
                    .collection("Data")
                    .doc(uid)
                    .collection("fine")
                    .doc(e.id)
                    .update({'status': "expired"});
              }

              if (e['status'] == "expired") {
                String amount = "";
                int amountInInt = 0;
                amount = e['amount'];
                amountInInt = int.parse(amount);
                final dateTime1 = DateTime.now();
                int FineWithTax = amountInInt + 1000;
                // print("amount");
                FirebaseFirestore.instance
                    .collection("Data")
                    .doc(uid)
                    .collection("fine")
                    .doc(e.id)
                    .update({
                  'amount': FineWithTax.toString(),
                  'expired': dateTime1.add(const Duration(days: 2)),
                  'status': "updated",
                });
              }
              final Timestamp timestamp1 = e['expired'] as Timestamp;
              final DateTime dateTime1 = timestamp1.toDate();
              final dateString1 = DateFormat("dd, MMM").format(dateTime1);

              final Timestamp timestamp2 = e['date'] as Timestamp;
              final DateTime dateTime2 = timestamp2.toDate();
              final dateString2 = DateFormat("dd, MMM").format(dateTime2);
              // if (e['limit'] == "exceed") {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => Videopalyer(
              //                 docId: e.id,
              //                 Uid: uid,
              //               )));
              // }
              print("here");
              return Stack(children: [
                (e['limit'] == "exceed")
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Videopalyer(Uid: uid, docId: e.id))
                    : Card(
                        color: (e['status'] == "updated")
                            ? Color.fromARGB(255, 62, 67, 46)
                            : Color.fromARGB(255, 97, 111, 57),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 20.0),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 165, 201, 202),
                                        height: 36,
                                      )),
                                ),
                                Text(
                                  "Fine Details",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 165, 201, 202),
                                      fontSize: 20),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 10.0),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 165, 201, 202),
                                        height: 36,
                                      )),
                                )
                              ],
                            ),
                            (e['status'] == "updated")
                                ? Text(
                                    "Expired",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Not Expired",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Fine Description:",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      // fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    e['description'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Type:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    e['type'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "amount:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    e['amount'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Date:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    dateString2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Pay Before:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    dateString1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 20.0),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 165, 201, 202),
                                        height: 36,
                                      )),
                                ),
                                Text(
                                  "Officer Details",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 165, 201, 202),
                                      fontSize: 20),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 10.0),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 165, 201, 202),
                                        height: 36,
                                      )),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Officer Name:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    e['officername'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Station:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    e['station'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 167, 209, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => crediCardPage(
                                                officerID: e['oficeuid'],
                                                userId: uid,
                                                docId: e['docid'],
                                                did: e.id,
                                                email: email.toString(),
                                                date: dateString2,
                                                amount: e['amount'],
                                                description: e['description'],
                                                type: e['type'],
                                                station: e['station'],
                                              )));
                                },
                                child: Text(
                                  "Pay now",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
              ]);
            }).toList(),
          );
        },
      ),
    );
  }
}
