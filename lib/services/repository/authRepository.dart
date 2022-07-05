// import 'dart:convert';
//
// import 'package:frontend/models/loginRequestModel.dart';
//
// import '../../models/registerRequestModel.dart';
// import '../configs/configHTTP.dart';
//
// import 'package:http/http.dart' as http;
//
// class AuthRepository {
//   var urlRegister = Uri.parse(ConfigHTTP.apiRegister);
//   var urlLogin = Uri.parse(ConfigHTTP.apiLogin);
//
//   /// register
//   Future<dynamic> registerCallApi(
//       String? email, String? password, String? name) async {
//     var body = jsonEncode({'email': email, 'password': password, 'name': name});
//     var response = await http.post(urlRegister, body: body, headers: {
//       "Accept": "application/json",
//       "content-type": "application/json"
//     });
//     return response;
//   }
//
//   //// login
//   Future<dynamic> loginCallApi(String? email, String? password) async {
//     var body = jsonEncode({
//       'email': email,
//       'password': password,
//     });
//     var response = await http.post(urlLogin, body: body, headers: {
//       "Accept": "application/json",
//       "content-type": "application/json"
//     });
//     return response;
//   }
// }
