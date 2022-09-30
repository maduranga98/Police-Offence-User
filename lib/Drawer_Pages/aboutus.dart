// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class aboutus extends StatefulWidget {
  const aboutus({super.key});

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  final number = '0741255849';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Container(
              child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Image.asset(
                'assets/police.jpg',
              ),
              Text("About Us",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Towards a Peaceful environment to live with confidence, without fear fo Crime and Violence",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
              ),
              Text("Our Mission",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Sri Lankan Police is Committes and confident to upload and enforce the law of the land, to preserve the public order, prevent crime and Terrorism with prejudice to none-equilty to all.",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
