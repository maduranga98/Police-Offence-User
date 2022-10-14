import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(title: 'Station', snippet: specify['name']));
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() {
    FirebaseFirestore.instance
        .collection("Map")
        .doc()
        .collection("Colombo")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          initMarker(value.docs[i].data(), value.docs[i].data());
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      // ignore: prefer_collection_literals
      return <Marker>[
        const Marker(
            markerId: MarkerId("places"),
            position: LatLng(6.914167, 79.848889),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Kollupitiya')),
        const Marker(
            markerId: MarkerId("places"),
            position: LatLng(6.878222, 79.874139),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Kirulapana')),
        const Marker(
            markerId: MarkerId("places"),
            position: LatLng(6.925472, 79.855778),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Bambalapitiya')),
        const Marker(
            markerId: MarkerId("places"),
            position: LatLng(6.925472, 79.855778),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Narahenpita')),
        const Marker(
            markerId: MarkerId("places"),
            position: LatLng(7.128778, 79.877367),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Seeduwa')),
        const Marker(
            markerId: MarkerId("places"),
            position: LatLng(6.928056, 79.865417),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Maradana')),
      ].toSet();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        backgroundColor: Color.fromARGB(255, 115, 3, 192),
        centerTitle: true,
      ),
      body: GoogleMap(
          markers: getMarker(),
          mapType: MapType.hybrid,
          initialCameraPosition: const CameraPosition(
            target: LatLng(6.927079, 79.861244),
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) =>
              _mapController = controller),
    );
  }
}
