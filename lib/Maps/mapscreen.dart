import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:police_offence_user/Maps/location_search_dialog.dart';

import 'location_controller.dart';
import 'package:flutter/material.dart';

class MapScreen5 extends StatefulWidget {
  const MapScreen5({super.key});

  @override
  State<MapScreen5> createState() => _MapScreen5State();
}

class _MapScreen5State extends State<MapScreen5> {
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraPosition =
        const CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 17);
  }

  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Locationcontroller>(
      builder: (locationController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Maps'),
            backgroundColor: Color.fromARGB(255, 115, 3, 192),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                  initialCameraPosition: _cameraPosition,
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                  }),
              Positioned(
                top: 100,
                left: 10,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LocationSearchDialog(mapController: _mapController),
                      )),
                  // LocationSearchDialog(mapController: _mapController),
                  child: Container(
                    height: 50.0,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 25,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Text(
                          '${locationController.pickPlaceMark.name ?? ''}'
                          ' ${locationController.pickPlaceMark.locality ?? ''}'
                          '${locationController.pickPlaceMark.postalCode ?? ''}'
                          '${locationController.pickPlaceMark.country ?? ''}',
                          style: const TextStyle(fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
