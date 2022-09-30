// ignore_for_file: unused_import, must_be_immutable, non_constant_identifier_names, no_logic_in_create_state, avoid_print, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:police_offence_user/Bottom_Bar_Pages/historyPage.dart';
import 'package:police_offence_user/Bottom_Bar_Pages/home.dart';
import 'package:police_offence_user/Sub_Pages/LoadingPage.dart';
import 'package:police_offence_user/homepage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videopalyer extends StatefulWidget {
  String Uid, docId;
  Videopalyer({Key? key, required this.Uid, required this.docId});

  @override
  State<Videopalyer> createState() => _VideopalyerState(Uid: Uid, docId: docId);
}

class _VideopalyerState extends State<Videopalyer> {
  String Uid, docId;
  _VideopalyerState({required this.Uid, required this.docId});

  late YoutubePlayerController controller;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    const url = 'https://youtu.be/_NeEF1fwT4k';
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
          enableCaption: true,
          mute: false,
          loop: false,
          autoPlay: true,
          hideControls: true),
    );
  }

  @override
  void deactivate() {
    // ignore: todo
    // TODO: implement deactivate
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      builder: (context, palyer) => Center(child: palyer),
      player: YoutubePlayer(
        controller: controller,
        // onEnded: (metaData) => print("End11111111111111"),
        onReady: () => print("Ready1111111111111"),
        onEnded: (metaData) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Loading(
                Uid: Uid,
                docId: docId,
              ),
            )),
      ),
    );
  }
}
