import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/view/authScreen.dart';
import 'package:frontend/controllers/ControllerBinding.dart';
import 'package:frontend/view/homeScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'view/splashView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(<DeviceOrientation>[
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  //ControllerBinding().dependencies();
  await GetStorage.init();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialBinding: ControllerBinding(),
      home: SplashView(),
    );
  }
}

