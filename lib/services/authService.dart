import 'dart:async';
import 'dart:convert';

import 'package:frontend/controllers/authPageController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'configs/configHTTP.dart';
import '../controllers/checkTokenController.dart';

class AuthService {
  final auth = Get.find<AuthPageController>();

  var urlRegister = Uri.parse(ConfigHTTP.apiRegister);
  var urlLogin = Uri.parse(ConfigHTTP.apiLogin);

  late Map resMapLogin;
  late Map resMapRegister;
  late int statusCode = 0;
  late String resMessage = "0";

  loginCallApi() async {
    resMapLogin = {};
    statusCode = 0;
    resMessage = "0";
    try {
      var resLogin = await loginSendApi(
              auth.loginRequest.email, auth.loginRequest.password)
          .timeout(const Duration(seconds: 5));
      resMapLogin = jsonDecode(utf8.decode(resLogin.bodyBytes));
      statusCode = resLogin.statusCode;
    } on TimeoutException catch (e) {
      resMessage = "timeOut";
      //print('Error catch : : ${e.toString()}');
    } on Error catch (e) {
      resMessage = "Error catch : ${e.toString()}";
    }

    if (statusCode == 200) {
      resMessage = "200";
      //print('\nResponse body token: ${resMapLogin["token"]}');
      Get.find<CheckTokenController>().login(resMapLogin["token"]);
      Get.delete<AuthPageController>();
      //Get.delete<AuthService>();
    }
    if (resMapLogin["error"] != null) {
      resMessage = resMapLogin["error"];
    }
    return resMessage;
  }

  registerCallApi() async {
    resMapRegister = {};
    statusCode = 0;
    resMessage = "0";
    try {
      var resRegister = await registerSendApi(auth.registerRequest.email,
              auth.registerRequest.password, auth.registerRequest.name)
          .timeout(const Duration(seconds: 5));
      resMapRegister = jsonDecode(utf8.decode(resRegister.bodyBytes));
      statusCode = resRegister.statusCode;
    } on TimeoutException catch (e) {
      resMessage = "timeOut";
      //print("TimeOut");
    } on Error catch (e) {
      resMessage = ("Error catch : $e");
      //print("Error : $e");
    }

    if (statusCode == 200) {
      resMessage = "200";
      //print('\nResponse body token: ${resMapLogin["token"]}');
      Get.find<CheckTokenController>().login(resMapRegister["token"]);
      Get.delete<AuthPageController>();
      Get.delete<AuthService>();
    }
    if (resMapRegister["error"] != null) {
      resMessage = resMapRegister["error"];
    }
  }



  ////// Send
  Future<dynamic> registerSendApi(
      String? email, String? password, String? name) async {
    var body = jsonEncode({'email': email, 'password': password, 'name': name});
    var response = await http.post(urlRegister, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    return response;
  }

  Future<dynamic> loginSendApi(String? email, String? password) async {
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(urlLogin, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    return response;
  }
}

// Future<void> registerCallApi() async {
//   var body = jsonEncode({
//     'email': auth.registerRequest.email,
//     'password': auth.registerRequest.password,
//     'name': auth.registerRequest.name
//   });
//   var url = Uri.parse(ConfigHTTP.apiRegister);
//   var response = await http.post(url, body: body, headers: {
//     "Accept": "application/json",
//     "content-type": "application/json"
//   });
//   Map resMap = jsonDecode(utf8.decode(response.bodyBytes));
//   if (response.statusCode == 200) {
//     auth.clearPage();
//     print('\nResponse status: ${response.statusCode}');
//     print('\nResponse message: ${resMap["error"]}');
//     print('\nResponse body data: ${resMap["data"]}');
//     print('\nResponse body token: ${resMap["token"]}');
//     Get.find<CheckTokenController>().login(resMap["token"]);
//   } else {
//     print('\nResponse message: ${resMap["error"]}');
//     print('\nResponse status: ${response.statusCode}');
//     print('\nResponse body data: ${resMap["data"]}');
//     print('\nResponse body token: ${resMap["token"]}');
//     Get.snackbar(
//       "Register Report Status",
//       '${resMap["message"]}',
//       icon: const Icon(Icons.person, color: Colors.white),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: CustomTheme.warningSnackBar2,
//       colorText: CustomTheme.white,
//     );
//     // null;
//   }
// }

// Future<void> loginCallApi() async {
//
//   var body = jsonEncode({
//     'email': auth.loginRequest.email,
//     'password': auth.loginRequest.password
//   });
//   var url = Uri.parse(ConfigHTTP.apiLogin);
//   var response = await http.post(url, body: body, headers: {
//     "Accept": "application/json",
//     "content-type": "application/json"
//   });
//
//   Map resMap = jsonDecode(utf8.decode(response.bodyBytes));
//   if (response.statusCode == 200) {
//     auth.clearPage();
//     print('\nResponse status: ${response.statusCode}');
//     print('\nResponse message: ${resMap["error"]}');
//     print('\nResponse body data: ${resMap["data"]}');
//     print('\nResponse body token: ${resMap["token"]}');
//     Get.find<CheckTokenController>().login(resMap["token"]);
//   } else {
//     print('\nResponse message: ${resMap["error"]}');
//     print('\nResponse status: ${response.statusCode}');
//     print('\nResponse body data: ${resMap["data"]}');
//     print('\nResponse body token: ${resMap["token"]}');
//     Get.snackbar(
//       "Register Report Status",
//       '${resMap["message"]}',
//       icon: const Icon(Icons.person, color: Colors.white),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: CustomTheme.warningSnackBar2,
//       colorText: CustomTheme.white,
//     );
//     // null;
//   }
//   Get.defaultDialog(
//     title: '',
//     middleText: '',
//   );
// }

//var url = Uri.parse(ConfigHTTP.apiLogin);
// Map body = {
//   "email": auth.loginRequest.email.toString(),
//   "password": auth.loginRequest.password.toString()
// };
//
// var request = http.MultipartRequest('POST', url);
// request.headers.addAll({
// "Content-type": "application/json",
// });
// request.fields['request'] = jsonEncode(body);
// var response = await request.send();
// var result = await http.Response.fromStream(response);
// Map resMap = jsonDecode(utf8.decode(result.bodyBytes));
