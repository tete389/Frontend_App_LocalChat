import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:frontend/models/chatRoomResponseModel.dart';
import 'package:frontend/models/locationResponseModel.dart';
import 'package:frontend/services/chatSearchService.dart';
import 'package:geolocator/geoLocator.dart';
import 'package:get/get.dart';

import '../services/geolocatorService.dart';
import 'chattingController.dart';
import 'locationController.dart';

class ChatSearchController extends GetxController {
  final _chatMessage = Get.put(ChattingController());

  ChatSearchService chatSearchService = ChatSearchService();
  late var getChatRoom = ChatRoomResponseModel();
  final location = Get.find<LocationController>();

  GeoLocatorService geoLocatorService = GeoLocatorService();

  late final RxBool notFound = true.obs;
  final RxBool notConnectApi = true.obs;
  //final RxBool searching = true.obs;
  final RxBool notYetSearch = true.obs;
  final RxBool searchState = false.obs;
  final RxBool loading = false.obs;
  final RxString searching = 'not'.obs;
  late List itemsArea = [].obs;
  late List<String> locationInArea = [];
  //String crId = "no data";
  final RxList<bool> isToggleArea = [false, false, false, false, false].obs;
  late Position? userLocation;

  @override
  void onInit() {
    _loadArea();
    notYetSearch(true);
    notConnectApi(true);
    super.onInit();
  }

  _loadArea() async {
    var infoArea = await chatSearchService.getArea();
    //print("${json.decode(infoArea)}");
    itemsArea = infoArea["area"];
    //print("${itemsArea}");
  }

  Future<void> toggleArea(int index) async {
    if (!isToggleArea[index]) {
      for (int i = 0; i < isToggleArea.length; i++) {
        isToggleArea[i] = false;
      }
      isToggleArea[index] = true;
      locationInArea = [];
      update();
      await getLocationInArea(index);
      await openAndCloseLoadingDialogChatSearch();
      update();
      return;
    }
    isToggleArea[index] = false;
    update();
  }

  infoChatMessage(String crId, String crName, String crImg) {
    _chatMessage.reactiveCrId = crId;
    _chatMessage.reactiveCrName = crName;
    _chatMessage.reactiveCrImg.value = crImg;
    print(_chatMessage.reactiveCrImg.value);
    _chatMessage.loadingChatMessage();
  }

  getLocationInArea(int index) async {
    print(location.getLocation.result!.length);
    if (location.getLocation.result == null) {
      return;
    }

    userLocation = await getUserLocation();
    if (userLocation == null) {
      return;
    }

    for(ResultLocation res in location.getLocation.result!){
      double distanceCheck = calculateDistance(userLocation!.latitude, userLocation!.longitude, res.ldLatitude!, res.ldLongitude!);
      print(res.ldName);

      if(distanceCheck <= (index+1)/10 ){
        locationInArea.add(res.ldId!);
      }
      print(distanceCheck);
    }

    // for (int i = 0; i < location.getLocation.result!.length; i++) {
    //   locationInArea.add(location.getLocation.result![i].ldId!);
    // }
  }

  Future<Position?> getUserLocation() async {
    try {
      return await geoLocatorService.getGeoLocation();
    } catch (e) {
      return null;
    }
  }

  double calculateDistance(
      double userLat, double userLong, double ldLat, double ldLong) {
    double distance = 0;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((ldLat - userLat) * p) / 2 +
        c(userLat * p) * c(ldLat * p) * (1 - c((ldLong - userLong) * p)) / 2;
    distance = 12742 * asin(sqrt(a));
    return distance ;
  }

  Future<void> openAndCloseLoadingDialogChatSearch() async {
    searching('searching');
    loading(true);
    notYetSearch(false);
    //dialogLoading();
    //await Future.delayed(const Duration(seconds: 2));
    //final callApi = Get.find<LocationService>();
    //var locationList = await callApi.getLocationCallApi();

    var charRoomList =
        await chatSearchService.getChatRoomCallApi(locationInArea);
    if (chatSearchService.statusCode == 200) {
      // for (int i = 0; i < locationList['result'].length; i++) {
      getChatRoom = ChatRoomResponseModel.fromJson(charRoomList);
      notFound(false);
      notConnectApi(false);
      searching('compile');
      //}
      print('${getChatRoom.resultChatRoom!.length}');
    } else {
      notFound(true);
      notConnectApi(true);
    }
    loading(false);
    //searching('not');
    //print('${ChatRoomResponseModel.fromJson(charRoomList).result?[0].crId}');
    //print('${locationList['result'][0]}');
    //print('${getChatRoom.result?[1].crId}');
  }
}
