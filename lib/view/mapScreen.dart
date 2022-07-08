import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/locationController.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  final location = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      //Container()
      Obx(
        () =>
            GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              location.mapController.complete(controller);
            },
            markers: Set<Marker>.of(location.markers),
            myLocationEnabled:
                location.searchGeoLocation.value == "compile" ? true : false,
            initialCameraPosition: location.searchGeoLocation.value == "compile"
                ? location.onCameraPosition()
                : location.onCameraPositionDefault()),
      ),
    );
  }
}
// FutureBuilder(
// future: location.geoLocatorService.getGeoLocation(),
// builder: (BuildContext context, AsyncSnapshot snapshot) {
// if (snapshot.hasData) {
// return GoogleMap(
// mapType: MapType.normal,
// onMapCreated: location.onMapCreated,
// myLocationEnabled: true,
// initialCameraPosition: location.onCameraPosition(),
// );
// } else {
// return Center(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Padding(
// padding: EdgeInsets.all(16.0),
// child: CircularProgressIndicator(),
// ),
// Text('Loading...'),
// ],
// ),
// );
// }
// },
// ),
