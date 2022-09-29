// // ignore_for_file: sized_box_for_whitespace

// import 'dart:async';

// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// import 'package:police_offence_user/auto_complete_result.dart';
// import 'package:police_offence_user/map_service.dart';
// import 'package:police_offence_user/serachplaces.dart';

// class MapScreen3 extends ConsumerStatefulWidget {
//   const MapScreen3({Key? key}) : super(key: key);

//   @override
//   _MapScreen3State createState() => _MapScreen3State();
// }

// class _MapScreen3State extends ConsumerState<MapScreen3> {
//   Completer<GoogleMapController> _controller = Completer();
//   Timer? _debounce;
//   bool searchToggle = false;
//   bool radiyusSlider = false;
//   bool pressedNear = false;
//   bool cardTapped = false;
//   bool getDirection = false;

//   //marker set
//   Set<Marker> _marker = Set<Marker>();
//   Set<Marker> _markersDupe = Set<Marker>();
//   Set<Polyline> _polylines = Set<Polyline>();

//   int markerIdCounter = 1;
//   int polylineIdCounter = 1;

//   TextEditingController searchController = TextEditingController();
//   static final CameraPosition _kGooglePlex =
//       const CameraPosition(target: LatLng(7.4721, 80.0446), zoom: 10.0);
//   LocationData? currentLocation;
//   Future<void> getCurrentLocation() async {
//     Location location = Location();
//     location.getLocation().then((location) => currentLocation = location);
//     GoogleMapController googleMapController = await _controller.future;
//   }

//   void _setMarker(point) {
//     var counter = markerIdCounter++;

//     final Marker marker = Marker(
//         markerId: MarkerId('marker_$counter'),
//         position: point,
//         onTap: () {},
//         icon: BitmapDescriptor.defaultMarker);

//     setState(() {
//       _marker.add(marker);
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     getCurrentLocation();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     //Providers
//     final allSearchResults = ref.watch(placeResultsProvider);
//     final searchflag = ref.watch(searchToggleProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Maps"),
//         backgroundColor: Color.fromARGB(255, 115, 3, 192),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: screenHeight,
//                 width: screenWidth,
//                 child: GoogleMap(
//                   mapType: MapType.normal,
//                   initialCameraPosition: _kGooglePlex,
//                   onMapCreated: (GoogleMapController contoller) {
//                     _controller.complete(contoller);
//                   },
//                   markers: {
//                     currentLocation == null
//                         ? Marker(markerId: MarkerId('asd'))
//                         : Marker(
//                             infoWindow:
//                                 InfoWindow(title: "Tap to get Directions"),
//                             markerId: MarkerId('current Location'),
//                             position: LatLng(currentLocation!.latitude!,
//                                 currentLocation!.longitude!))
//                   },
//                 ),
//               ),
//               searchToggle
//                   ? Padding(
//                       padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
//                       child: Column(children: [
//                         Container(
//                           height: 50.0,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               color: Colors.white),
//                           child: TextFormField(
//                             controller: searchController,
//                             decoration: InputDecoration(
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 15.0),
//                               border: InputBorder.none,
//                               hintText: 'Search',
//                               suffixIcon: IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     searchToggle = false;
//                                     searchController.text = '';
//                                     _marker = {};
//                                     if (searchflag.searchToggle)
//                                       searchflag.toggleSearch();
//                                   });
//                                 },
//                                 icon: const Icon(Icons.close),
//                               ),
//                             ),
//                             onChanged: (value) {
//                               print("Value: $value");
//                               if (_debounce?.isActive ?? false)
//                                 _debounce?.cancel();

//                               _debounce = Timer(
//                                   const Duration(milliseconds: 700), () async {
//                                 if (value.length > 2) {
//                                   if (!searchflag.searchToggle) {
//                                     searchflag.toggleSearch();
//                                     _marker = {};
//                                   }

//                                   List<AutoCompleteResult> searchResults =
//                                       await MapServices().searchPlaces(value);

//                                   allSearchResults.setResults(searchResults);
//                                   print("searchResults $searchResults");
//                                 } else {
//                                   List<AutoCompleteResult> emptyList = [];
//                                   allSearchResults.setResults(emptyList);
//                                 }
//                               });
//                             },
//                           ),
//                         )
//                       ]),
//                     )
//                   : Container(),
//               searchflag.searchToggle
//                   ? allSearchResults.allReturnedResults.length != 0
//                       ? Positioned(
//                           top: 100.0,
//                           left: 15.0,
//                           child: Container(
//                             height: 200.0,
//                             width: screenWidth - 30.0,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               color: Colors.white.withOpacity(0.7),
//                             ),
//                             child: ListView(
//                               children: [
//                                 ...allSearchResults.allReturnedResults
//                                     .map((e) => buildListItem(e, searchflag))
//                               ],
//                             ),
//                           ))
//                       : Positioned(
//                           top: 100.0,
//                           left: 15.0,
//                           child: Container(
//                             height: 200.0,
//                             width: screenWidth - 30.0,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               color: Colors.white.withOpacity(0.7),
//                             ),
//                             child: Center(
//                               child: Column(children: [
//                                 const Text('No results to show',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.w400)),
//                                 const SizedBox(height: 5.0),
//                                 Container(
//                                   width: 125.0,
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       searchflag.toggleSearch();
//                                     },
//                                     child: const Center(
//                                       child: Text(
//                                         'Close this',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w300),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ]),
//                             ),
//                           ))
//                   : Container()
//             ],
//           )
//         ],
//       )),
//       floatingActionButton: FabCircularMenu(
//         alignment: Alignment.bottomLeft,
//         fabColor: Colors.blue.shade50,
//         fabOpenColor: Colors.red.shade100,
//         ringDiameter: 250.0,
//         ringWidth: 60.0,
//         ringColor: Colors.blue.shade50,
//         fabSize: 60.0,
//         children: [
//           IconButton(
//               onPressed: (() {
//                 setState(() {
//                   searchToggle = true;
//                   radiyusSlider = false;
//                   pressedNear = false;
//                   cardTapped = false;
//                   getDirection = false;
//                 });
//               }),
//               icon: const Icon(Icons.search)),
//           IconButton(
//               onPressed: (() {
//                 setState(() {});
//               }),
//               icon: const Icon(Icons.navigation))
//         ],
//       ),
//     );
//   }

//   Future<void> gotoSearchedPlace(double lat, double lng) async {
//     final GoogleMapController controller = await _controller.future;

//     controller.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: LatLng(lat, lng), zoom: 12)));

//     _setMarker(LatLng(lat, lng));
//   }

//   Widget buildListItem(AutoCompleteResult placeItem, searchFlag) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: GestureDetector(
//         onTapDown: (_) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         onTap: () async {
//           var place = await MapServices().getPlace(placeItem.placeId);
//           print(place);
//           gotoSearchedPlace(place['geometry']['location']['lat'],
//               place['geometry']['location']['lng']);
//           searchFlag.toggleSearch();
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Icon(Icons.location_on, color: Colors.green, size: 25.0),
//             const SizedBox(width: 4.0),
//             Container(
//               height: 40.0,
//               width: MediaQuery.of(context).size.width - 75.0,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(placeItem.description ?? ''),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
