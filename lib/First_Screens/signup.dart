// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, unrelated_type_equality_checks, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:police_offence_user/homepage.dart';
import 'package:police_offence_user/First_Screens/loginPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final vehiclenumb = TextEditingController();
  final nic = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 305),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 200.0),
            Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // ignore: prefer_const_literals_to_create_immutables
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                                color: Color.fromARGB(255, 115, 3, 192)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
                      cursorColor: Color.fromARGB(255, 253, 239, 249),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Full name',
                        hintText: 'Full name',
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
                          Icons.person_sharp,
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
                      controller: name,
                      keyboardType: TextInputType.name,
                      validator: (value) =>
                          value!.isEmpty ? 'Name cannot be blank' : null,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
                      cursorColor: Color.fromARGB(255, 253, 239, 249),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'NIC',
                        hintText: 'NIC',
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
                          Icons.integration_instructions_outlined,
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
                      controller: nic,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value!.isEmpty ? 'NIC cannot be blank' : null,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
                      cursorColor: Color.fromARGB(255, 253, 239, 249),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Vehicle number',
                        hintText: 'Vehicle number',
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
                          Icons.car_repair_outlined,
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
                      controller: vehiclenumb,
                      keyboardType: TextInputType.text,
                      validator: (value) => value!.isEmpty
                          ? 'Vehicle number cannot be blank'
                          : null,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
                      cursorColor: Color.fromARGB(255, 253, 239, 249),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Email',
                        hintText: 'E-mail',
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
                          Icons.email_outlined,
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
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be blank' : null,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 253, 239, 249)),
                      cursorColor: Color.fromARGB(255, 253, 239, 249),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Password',
                        hintText: 'Password',
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
                          Icons.key_sharp,
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
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be blank' : null,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            MaterialButton(
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text.trim(),
                      password: password.text.trim(),
                    );
                    if (credential != Null) {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final User? user = auth.currentUser;
                      final uid = user!.uid;
                      FirebaseFirestore.instance
                          .collection("Data")
                          .doc(uid)
                          .set({
                        'username': name.text.trim(),
                        'id': nic.text.trim(),
                        'vnum': vehiclenumb.text.trim(),
                        'email': email.text.trim(),
                        'password': password.text.trim(),
                        'uid': uid,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      Fluttertoast.showToast(
                          msg: "Welcome to PoliceOffence",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Something went wrong!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              height: 45,
              color: Colors.black,
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Loginpage())),
                  child: Text(
                    'LogIn',
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
