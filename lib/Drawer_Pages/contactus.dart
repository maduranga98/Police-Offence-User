// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_unnecessary_containers, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class contactus extends StatefulWidget {
  const contactus({super.key});

  @override
  State<contactus> createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  final number = '0382238555';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 305),
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 115, 3, 192),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    'assets/contact.gif',
                    // height: 500.0,
                    // width: 200.0,
                  )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 5.0, right: 5.0, bottom: 10.0),
            child: Text(
              "Any Question or Remark? just Call us or Email us",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.cyan,
            width: 300,
            height: 190,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Contact Information',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Divider(),
                // ignore: prefer_const_literals_to_create_immutables
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutablesma
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '0382238555',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'nipunisathsarani@gmail.com',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Colombo',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
              icon: Icon(Icons.call),
              onPressed: () async {
                await FlutterPhoneDirectCaller.callNumber('tel://$number');
              },
              label: Text("make a call"))
        ],
      ),
    );
  }
}
