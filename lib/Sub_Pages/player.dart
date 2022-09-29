// // ignore_for_file: sized_box_for_whitespace

// import 'package:flutter/material.dart';
// import 'package:police_offence_user/homepage.dart';
// import 'package:video_player/video_player.dart';

// class Palyer extends StatefulWidget {
//   const Palyer({super.key});

//   @override
//   State<Palyer> createState() => _PalyerState();
// }

// class _PalyerState extends State<Palyer> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     // _controller = VideoPlayerController.network(
//     //     "https://static.videezy.com/system/resources/previews/000/042/873/original/top_down_machine_asfalting_4K.mp4")
//     //   ..initialize().then((_) => {
//     //         setState(
//     //           () {
//     //             _controller.play();
//     //           },
//     //         )
//     //       });
//     _controller = VideoPlayerController.asset(
//         "assets/Road Safety video _ Traffic Rules And Signs For Kids _ Kids Educational Video.mp4")
//       ..initialize().then((_) => {
//             setState(
//               () {
//                 _controller.play();
//               },
//             )
//           });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Palyer")),
//       body: Column(
//         children: [
//           content(),
//           ElevatedButton(
//               onPressed: () {
//                 if (_controller.value.isPlaying) {
//                 } else {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const HomePage()));
//                 }
//               },
//               child: Text(_controller.value.isPlaying
//                   ? "You Should Watch this"
//                   : "Next"))
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(
//               _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           }),
//     );
//   }

//   Widget content() {
//     return Center(
//       child: Container(
//         width: 350,
//         height: 350,
//         child: _controller.value.isInitialized
//             ? VideoPlayer(_controller)
//             : Container(),
//       ),
//     );
//   }
// }
