// // ignore_for_file: prefer_const_constructors, file_names, avoid_function_literals_in_foreach_calls

// import 'dart:async';
// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:police_offence_user/constant.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   Completer<GoogleMapController> _controller = Completer();

//   static const LatLng sourceLocation = LatLng(7.4721, 80.0446);
//   static const LatLng destinationLocation = LatLng(7.4818, 80.3609);
//   List<LatLng> polylineCoordinates = [];
//   LocationData? currentLocation;
//   Future<void> getCurrentLocation() async {
//     Location location = Location();
//     location.getLocation().then((location) => currentLocation = location);
//     GoogleMapController googleMapController = await _controller.future;
//   }

//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         google_api_key,
//         PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//         PointLatLng(
//             destinationLocation.latitude, destinationLocation.longitude));
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) =>
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     getCurrentLocation();
//     getPolyPoints();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(),
//       body: currentLocation == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               physics: const NeverScrollableScrollPhysics(),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                       target: LatLng(currentLocation!.latitude!,
//                           currentLocation!.longitude!),
//                       zoom: 10.0),
//                   markers: {
//                     Marker(
//                         infoWindow: InfoWindow(title: "Tap to get Directions"),
//                         markerId: MarkerId('current Location'),
//                         position: LatLng(currentLocation!.latitude!,
//                             currentLocation!.longitude!))
//                   },
//                   // polylines: {
//                   //   Polyline(
//                   //       polylineId: PolylineId("route"),
//                   //       points: [LatLng(7.4721, 80.0446), LatLng(7.4818, 80.3609)],
//                   //       width: 6,
//                   //       color: Colors.blue)
//                   // },
//                   onMapCreated: (mapController) {
//                     _controller.complete(mapController);
//                   },
//                 ),
//               ),
//             ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black45,
//         onPressed: getCurrentLocation,
//         child: Icon(Icons.location_searching),
//       ),
//     );
//   }
// }
