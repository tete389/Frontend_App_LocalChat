
import 'dart:convert';

import 'package:frontend/models/chatRoomResponseModel.dart';
import 'package:frontend/services/chatSearchService.dart';
import 'package:get/get.dart';

import 'chattingController.dart';
import 'locationController.dart';

class ChatSearchController extends GetxController {
  final _chatMessage = Get.put(ChattingController());

  ChatSearchService chatSearchService = ChatSearchService();
  late var getChatRoom = ChatRoomResponseModel();
  final location = Get.find<LocationController>();

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
    if(!isToggleArea[index]){
      for (int i = 0; i < isToggleArea.length; i++) {
        isToggleArea[i] = false;
      }
      isToggleArea[index] = true;
      locationInArea = [];
      update();
      await getLocationInArea();
      await openAndCloseLoadingDialogChatSearch();
      update();
      return;
    }
    isToggleArea[index] = false;
    update();
  }

  infoChatMessage(String crId,String crName, String crImg)  {
    _chatMessage.reactiveCrId = crId;
    _chatMessage.reactiveCrName = crName;
    _chatMessage.reactiveCrImg.value = crImg;
    print(_chatMessage.reactiveCrImg.value);
    _chatMessage.loadingChatMessage();
  }

getLocationInArea() {
    print(location.getLocation.result!.length);
    if(location.getLocation.result == null){
      return;
    }
    for(int i = 0 ; i < location.getLocation.result!.length ; i++){
      locationInArea.add(location.getLocation.result![i].ldId!);
    }
}



  Future<void> openAndCloseLoadingDialogChatSearch() async {
    searching('searching');
    loading(true);
    notYetSearch(false);
    //dialogLoading();
    //await Future.delayed(const Duration(seconds: 2));
    //final callApi = Get.find<LocationService>();
    //var locationList = await callApi.getLocationCallApi();

    var charRoomList = await chatSearchService.getChatRoomCallApi(locationInArea);
    if (chatSearchService.statusCode == 200) {
      // for (int i = 0; i < locationList['result'].length; i++) {
      getChatRoom = ChatRoomResponseModel.fromJson(charRoomList);
      notFound(false);
      notConnectApi(false);
      searching('compile');
      //}
      print('${getChatRoom.resultChatRoom!.length}');
    }else{

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