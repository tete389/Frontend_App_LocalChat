import 'dart:async';
import 'dart:convert';


import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/locationResponseModel.dart';
import 'configs/configHTTP.dart';
import '../controllers/checkTokenController.dart';

class LocationService {
  final userStorage = Get.find<CheckTokenController>();
  var urlGetLocation = Uri.parse(ConfigHTTP.apiGetLocation);

  LocationResponseModel responseModel = LocationResponseModel();

  late List<LocationResponseModel> resLocation;
  late Map<String, dynamic> resMap;
  //late Map resMap;
  late int statusCode;
  late String resMessage = "0";


  getLocationCallApi() async {
    resMap = {};
    statusCode = 0;
    resMessage = "0";
    try {
      var resLocation = await getLocationData().timeout(const Duration(seconds: 5));
      statusCode = resLocation.statusCode;
      resMap = jsonDecode(utf8.decode(resLocation.bodyBytes));
      //print('${LocationResponseModel.fromJson(resMap).result?[0].ldId}');
    } on TimeoutException catch (e) {
      resMessage = "timeOut";
    } on Error catch (e) {
      resMessage = "Error catch : ${e.toString()}";
    }

    if (statusCode == 200) {
      resMessage = "200";
      return resMap;
      print('\nResponse body token: $resLocation');
      //
     //print('\nResponse body token: ${resMap['result'][0]['ldId']}');
      //print('\nResponse body token: $resMap');

      //print('\nResponse body token: ${resMap['result']}');

      //Get.find<CheckTokenController>().login(resMapLogin["token"]);
      //print('\nResponse body token: ${responseModel.result}');
      // List<Result>? re = responseModel.result;
      // Result result = re![0];
      //print('\nResponse body token: ${result.ldAddress}');
    }
    if(statusCode != 200){
      return resMap;
    }

    // if (resMap["error"] != null) {
    //   print('\nResponse body token: ${resMap["result"]}');
    // }
    print('\nResponse body token: ${statusCode}');

  }

  // registerCallApi() async {
  //   resMapRegister = ({});
  //   statusCode.value = 0;
  //   resMessage.value = "0";
  //   try {
  //     var resRegister = await registerSendApi(auth.registerRequest.email,
  //             auth.registerRequest.password, auth.registerRequest.name)
  //         .timeout(const Duration(seconds: 5));
  //     resMapRegister = jsonDecode(utf8.decode(resRegister.bodyBytes));
  //     statusCode.value = resRegister.statusCode;
  //   } on TimeoutException catch (e) {
  //     resMessage.value = "timeOut";
  //     //print("TimeOut");
  //   } on Error catch (e) {
  //     resMessage.value = ("Error catch : $e");
  //     //print("Error : $e");
  //   }
  //
  //   if (statusCode.value == 200) {
  //     resMessage.value = "200";
  //     //print('\nResponse body token: ${resMapLogin["token"]}');
  //     Get.find<CheckTokenController>().login(resMapRegister["token"]);
  //     Get.delete<AuthPageController>();
  //     Get.delete<AuthService>();
  //   }
  //   if (resMapRegister["error"] != null) {
  //     resMessage.value = resMapRegister["error"];
  //   }
  // }
  //
  //
  //
  // ////// Send
  // Future<dynamic> registerSendApi(
  //     String? email, String? password, String? name) async {
  //   var body = jsonEncode({'email': email, 'password': password, 'name': name});
  //   var response = await http.post(urlRegister, body: body, headers: {
  //     "Accept": "application/json",
  //     "content-type": "application/json"
  //     ""
  //   });
  //   return response;
  // }
  //
  Future<dynamic> getLocationData() async {

    var response = await http.get(urlGetLocation , headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer ${userStorage.getToken()}"
    });
    return response;
  }
}
