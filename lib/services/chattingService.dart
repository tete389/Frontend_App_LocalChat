
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/checkTokenController.dart';
import 'configs/configHTTP.dart';

class ChattingService {
  final userStorage = Get.find<CheckTokenController>();
  var urlGetMessage = Uri.parse(ConfigHTTP.apiGetMessageInChatRoom);

  late Map<String, dynamic> resMap;
  //late Map resMap;
  late int statusCode;
  late String resMessage = "0";

  getChatMessageCallApi(String crId) async {
    resMap = {};
    statusCode = 0;
    resMessage = "0";
    try {
      var resChat = await getChatMessage(crId).timeout(const Duration(seconds: 5));
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
  }

  Future<dynamic> getChatMessage(String crId) async {
    var chatRoomId =
      {"crId": crId};

    var body = jsonEncode(chatRoomId);
    var response = await http.post(urlGetMessage,body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer ${userStorage.getToken()}"
    });
    return response;
  }
}