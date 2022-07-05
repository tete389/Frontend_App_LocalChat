import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/models/locationResponseModel.dart';
import 'package:frontend/services/geolocatorService.dart';
import 'package:geolocator/geoLocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/locationService.dart';
import '../view/theme/customTheme.dart';

class LocationController extends GetxController {
  var getLocation = LocationResponseModel();
  LocationService locationService = LocationService();
  GeoLocatorService geoLocatorService = GeoLocatorService();

  final Completer<GoogleMapController> mapController = Completer();

  var tabIndex = 0.obs;
  final RxBool loading = false.obs;
  final RxString searchLocation = "not".obs;
  final RxString searchGeoLocation = "not".obs;
  var locationItem = [];

  late Marker marker;
  List<Marker> markers = <Marker>[].obs;

  late Position? userLocation;

  @override
  void onInit() {
    getUserLocation();
    openAndCloseLoadingDialogLocation();
    super.onInit();
  }

  Future<void> getUserLocation() async {
    searchGeoLocation("searching");
    try {
      userLocation = await geoLocatorService.getGeoLocation();
      print("com");
      if (userLocation != null) {
        print("compile");
        searchGeoLocation("compile");
      }
    } catch (e) {
      // = mapController as Position;
      searchGeoLocation("fail");
    }
  }

  dynamic onCameraPositionDefault() {
    return const CameraPosition(
        target: LatLng(16.430848812, 102.863312223), zoom: 18.0);
  }

  dynamic onCameraPosition() {
    return CameraPosition(
        target: LatLng(userLocation!.latitude, userLocation!.longitude),
        zoom: 18.0);
  }

  getMarkers() {
    getLocation.result!.asMap().forEach((key, value) {
      var _marker = Marker(
          markerId: MarkerId(value.ldId.toString()),
          //consumeTapEvents: true,
          position: LatLng(value.ldLatitude!, value.ldLongitude!),
          infoWindow: InfoWindow(
            title: value.ldName,
            snippet: value.ldDetail,
            onTap: () =>
                _openOnGoogleMapApp(value.ldLatitude!, value.ldLongitude!),
          ));
      markers.add(_marker);
    });
    update();
  }

  _openOnGoogleMapApp(double lat, double long) async {
    Uri googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {}
  }

  /////// Dialog
  dialogLoading() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              color: CustomTheme.primaryTheme,
              strokeWidth: 10,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openAndCloseLoadingDialogLocation() async {
    searchLocation('searching');
    loading(true);
    //dialogLoading();
    //await Future.delayed(const Duration(seconds: 2));
    //final callApi = Get.find<LocationService>();
    //var locationList = await callApi.getLocationCallApi();

    var locationList = await locationService.getLocationCallApi();
    if (locationService.statusCode == 200) {
      // for (int i = 0; i < locationList['result'].length; i++) {
      getLocation = LocationResponseModel.fromJson(locationList);
      searchLocation('compile');
      await getMarkers();
      //}
    }

    //print('${LocationResponseModel.fromJson(locationList).result?[0].ldId}');
    print('${getLocation.result?[0].ldLatitude}');
    print('${getLocation.result?[0].ldLongitude}');

    print('${getLocation.result?[0].ldId}');
    loading(false);
  }

  /// close dialog loading
  //Navigator.of(Get.overlayContext!).pop();

  // if (authApi.resMessage.value == "timeOut") {
  //   diaLogTimeout();
  // } else if (authApi.resMessage.value == "sign_up.fail.email.duplicate") {
  //   diaLogUserDuplicate();
  // } else if(authApi.resMessage.value != "200"){
  //   diaLogFail();
  // }

}
