// ignore_for_file: implementation_imports, depend_on_referenced_packages, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:police_offence_user/Maps/location_controller.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  LocationSearchDialog({required this.mapController});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 150),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: 250,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: 'search location',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(style: BorderStyle.none, width: 0)))),
            suggestionsCallback: (pattern) async {
              return await Get.find<Locationcontroller>()
                  .searchLocation(context, pattern);
            },
            onSuggestionSelected: (Prediction suggestion) {
              print("My location is " + suggestion.description!);
              // Get.find<Locationcontroller>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
              Get.back();
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                        suggestion.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
