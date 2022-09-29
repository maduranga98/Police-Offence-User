import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/src/places.dart';
import 'package:police_offence_user/Maps/location_service.dart';

class Locationcontroller extends GetxController {
  Placemark pickPlaceMark = Placemark();
  Placemark get pickPlacemark => pickPlacemark; //_pickPlacemark
  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text != null && text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("my status is " + data['status']);
      if (data['status'] == 'OK') {
        _predictionList = [];
        data['prediction'].forEach((prediction) =>
            _predictionList.add(prediction.fromJson(prediction)));
      } else {}
    }

    return _predictionList;
  }
}
