// ignore_for_file: prefer_const_constructors, must_be_immutable, camel_case_types, deprecated_member_use, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, use_key_in_widget_constructors, no_logic_in_create_state, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class crediCardPage extends StatefulWidget {
  String userId,
      officerID,
      docId,
      did,
      email,
      date,
      type,
      amount,
      description,
      station;
  crediCardPage(
      {Key? key,
      required this.userId,
      required this.officerID,
      required this.docId,
      required this.did,
      required this.email,
      required this.date,
      required this.type,
      required this.amount,
      required this.description,
      required this.station});

  @override
  State<crediCardPage> createState() => _crediCardPageState(
      userId: userId,
      officerID: officerID,
      docId: docId,
      did: did,
      email: email,
      date: date,
      type: type,
      amount: amount,
      description: description,
      station: station);
}

class _crediCardPageState extends State<crediCardPage> {
  String userId,
      officerID,
      docId,
      did,
      email,
      date,
      type,
      amount,
      description,
      station;
  _crediCardPageState(
      {required this.userId,
      required this.officerID,
      required this.docId,
      required this.did,
      required this.email,
      required this.date,
      required this.type,
      required this.amount,
      required this.description,
      required this.station});
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SendMails() async {
    String username = 'policeoffence@gmail.com';
    String password = 'crvbtwtdimjhmbik';

    final smtpServer = gmail(username, password);
    var datetime = DateTime.now();
    final dateString = DateFormat("dd MMM, yyyy").format(datetime);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(email)
      ..subject = 'About Payment  $dateString'
      ..text = 'Thank for your payment amount for description on date'
      ..html =
          "<h1>Thank for your payment</h1>\n<p>Details are as below:</p>\n<p>Date: $date </p>\n <p>Type: $type </p>\n <p>Amount: $amount </p>\n <p>Description: $description </p>\n <p>PoliceStation: $station </p>\n <p>UserId: $userId </p>\n <p>FineId: $docId </p>";

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(
          msg: "Message sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Fluttertoast.showToast(
          msg: "Your Payment is success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      Fluttertoast.showToast(
          msg: "Message not sent.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Error: ${e.toString()}");
      for (var p in e.problems) {
        Fluttertoast.showToast(
            msg: "'Problem: ${p.code}: ${p.msg}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 239, 249),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 115, 3, 192),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Column(
        children: [
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            onCreditCardWidgetChange: (CreditCardBrand) {},
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: onCreditCardModelChange,
                  themeColor: Colors.blue,
                  formKey: formKey,
                  cardNumberDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'xxxx xxxx xxxx xxxx'),
                  expiryDateDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expired Date',
                      hintText: 'xx/xx'),
                  cvvCodeDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'xxx'),
                  cardHolderDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: Color(0xff1b447b)),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      'validate',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'halter',
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                  onPressed: () {
                    // database update
                    FirebaseFirestore.instance
                        .collection("Office")
                        .doc(officerID)
                        .collection("fine")
                        .doc(docId)
                        .update({'mode': 'paid'});
                    FirebaseFirestore.instance
                        .collection("Data")
                        .doc(userId)
                        .collection("fine")
                        .doc(did)
                        .update({
                      'mode': 'paid',
                      'paiddate': DateTime.now(),
                    });

                    SendMails();
                    //end
                    if (formKey.currentState!.validate()) {
                      print('valid');
                    } else {
                      print('inValid');
                    }
                  },
                )
              ],
            ),
          )),
        ],
      )),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
