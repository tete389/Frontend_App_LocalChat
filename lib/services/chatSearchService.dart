import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/checkTokenController.dart';
import 'configs/configHTTP.dart';

class ChatSearchService {
  final userStorage = Get.find<CheckTokenController>();
  var urlGetChatRoom = Uri.parse(ConfigHTTP.apiGetChatRoomsByLocation);

  late Map<String, dynamic> resMap;
  //late Map resMap;
  late int statusCode;
  late String resMessage = "0";
  final List locationId = [];

  Future<dynamic> getArea() async {
    final String infoArea = await rootBundle.loadString("json/dataJson.json");
    final listArea = await json.decode(infoArea);
    //List<dynamic> list = listArea.map((e) => json.decode(e["area"])).toList();
    return listArea;
  }

  getChatRoomCallApi(List<String> locationInArea) async {
    locationId.clear();
    resMap = {};
    statusCode = 0;
    resMessage = "0";
    await manageLocationId(locationInArea);


    try {
      var resChat = await getChatRoomData().timeout(const Duration(seconds: 5));
      statusCode = resChat.statusCode;
      resMap = jsonDecode(utf8.decode(resChat.bodyBytes));
      //print('${LocationResponseModel.fromJson(resMap).result?[0].ldId}');
    } on TimeoutException catch (e) {
      resMessage = "timeOut";
    } on Error catch (e) {
      resMessage = "Error catch : ${e.toString()}";
    }

    if (statusCode == 200) {
      resMessage = "200";
      return resMap;
    }
    if (statusCode != 200) {
      return resMap;
    }

    // if (resMap["error"] != null) {
    //   print('\nResponse body token: ${resMap["result"]}');
    // }
    print('\nResponse body token: ${statusCode}');
  }

  Future<dynamic> getChatRoomData() async {
    print(locationId);
    var body = jsonEncode(locationId);
    var response = await http.post(urlGetChatRoom,body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer ${userStorage.getToken()}"
    });
    return response;
  }



    manageLocationId(List<String> location) async {
    for ( int i = 0 ; i< location.length ; i++){
      locationId.add({"crLocationId": location[i]});
    }
    //{"crLocationId": "45202d1a-79de-4371-8446-76b71651a946"},
    // {"crLocationId": "2fc8ed15-18b9-42c1-8627-072ff4ed8269"},
    // {"crLocationId": "a279bbd0-0a73-4c00-9407-446871b702b5"}
  }
}
