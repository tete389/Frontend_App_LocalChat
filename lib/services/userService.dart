
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/checkTokenController.dart';
import 'configs/configHTTP.dart';

class UserService {
  final userStorage = Get.find<CheckTokenController>();
  var urlGetUserProfile = Uri.parse(ConfigHTTP.apiGetUserProfile);

  late Map<String, dynamic> resMap;
  late int statusCode;
  late String resMessage = "0";

  getUserCallApi() async {
    resMap = {};
    statusCode = 0;
    resMessage = "0";
    try {
      var resUserProfile = await getUserProfile().timeout(const Duration(seconds: 5));
      statusCode = resUserProfile.statusCode;
      resMap = jsonDecode(utf8.decode(resUserProfile.bodyBytes));
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

  Future<dynamic> getUserProfile() async {
    var response = await http.get(urlGetUserProfile, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer ${userStorage.getToken()}"
    });
    return response;
  }
}