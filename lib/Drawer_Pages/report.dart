// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:police_offence_user/Sub_Pages/datacharts.dart';
import 'package:police_offence_user/Sub_Pages/dataseries.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  int A = 0, B = 0, C = 0, D = 0, paid = 0, notpaid = 0, expired = 0;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var date = DateTime.now();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 30),
      appBar: AppBar(title: Text("Report")),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Data')
              .doc(uid)
              .collection('fine')
              .where('month', isEqualTo: date.month)
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var ds = snapshot.data!.docs;
            for (int i = 0; i < ds.length; i++) {
              if (ds[i]['type'] == "A") {
                A = A + 1;
              } else if (ds[i]['type'] == "B") {
                B = B + 1;
              } else if (ds[i]['type'] == "C") {
                C = C + 1;
              } else if (ds[i]['type'] == "D") {
                D = D + 1;
              }
            }
            for (int i = 0; i < ds.length; i++) {
              if (ds[i]['mode'] == "paid") {
                paid = paid + 1;
              } else if (ds[i]['mode'] == "notpaid") {
                notpaid = notpaid + 1;
              } else if (ds[i]['status'] == "expired") {
                expired = expired + 1;
              }
            }
            print("A: $A");
            print("B: $B");
            print("C: $C");
            print("D: $D");
            print("Expire $expired");
            print("Paid: $paid");
            print("NotPaid: $notpaid");
            int totalA = A * 3000;
            int totalB = B * 4000;
            int totalC = C * 5000;
            int totalD = D * 6000;
            int total = totalA + totalB + totalC + totalD;
            int totalamount = A + B + C + D;
            List<dataseries> data = [
              dataseries(
                  type: "Paid",
                  value: paid,
                  barcolor: charts.ColorUtil.fromDartColor(Colors.white)),
              dataseries(
                  type: "NotPaid",
                  value: notpaid,
                  barcolor: charts.ColorUtil.fromDartColor(Colors.redAccent)),
              dataseries(
                  type: "Expired",
                  value: expired,
                  barcolor: charts.ColorUtil.fromDartColor(Colors.red)),
            ];
            //Pie charts
            final List<ChartData> chartData = [
              ChartData(x: 'A', y: A.toDouble(), color: Colors.yellow),
              ChartData(x: 'B', y: B.toDouble(), color: Colors.red),
              ChartData(x: 'C', y: C.toDouble(), color: Colors.blue),
              ChartData(x: 'D', y: D.toDouble(), color: Colors.white70)
            ];
            return Column(
              children: [
                Text(
                  "Report Month: ${DateTime.now().month}",
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: Color.fromARGB(255, 165, 201, 202),
                            height: 10,
                          )),
                    ),
                    Text(
                      "According to Fine Types",
                      style: TextStyle(
                          color: Color.fromARGB(255, 165, 201, 202),
                          fontSize: 20),
                    ),
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Color.fromARGB(255, 165, 201, 202),
                            height: 10,
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.white),
                    children: [
                      buildRow(['Type', 'Amount', 'Fine', 'Total'],
                          isHeader: true),
                      buildRow(['A', A.toString(), '3000', totalA.toString()]),
                      buildRow(['B', B.toString(), '4000', totalB.toString()]),
                      buildRow(['C', C.toString(), '5000', totalC.toString()]),
                      buildRow(['D', D.toString(), '6000', totalD.toString()]),
                      buildRow([
                        'Total',
                        totalamount.toString(),
                        '',
                        total.toString()
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 60.0,
                  color: Colors.cyan,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            CircleAvatar(
                              radius: 5.0,
                              backgroundColor: Colors.yellow,
                            ),
                            Text(" A"),
                          ],
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            CircleAvatar(
                              radius: 5.0,
                              backgroundColor: Colors.red,
                            ),
                            Text(" B"),
                          ],
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            CircleAvatar(
                              radius: 5.0,
                              backgroundColor: Colors.blue,
                            ),
                            Text(" C"),
                          ],
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            CircleAvatar(
                              radius: 5.0,
                              backgroundColor: Colors.white70,
                            ),
                            Text(" D"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                      child: SfCircularChart(series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ])),
                ),
                DataCharts(data: data)
              ],
            );
          }),
        ),
      )),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((e) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.bold,
            fontSize: 18.0);
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Text(
            e,
            style: TextStyle(color: Color.fromARGB(255, 165, 201, 202)),
          )),
        );
      }).toList());
}
