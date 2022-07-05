import 'package:flutter/material.dart';
import 'package:frontend/controllers/checkTokenController.dart';
import 'package:frontend/view/authScreen.dart';
import 'package:frontend/view/authScreenGetX.dart';
import 'package:frontend/view/homeScreen.dart';
import 'package:frontend/view/homeScreenGetX.dart';
import 'package:get/get.dart';

class OnBoardWidget extends StatelessWidget {
  const OnBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<CheckTokenController>();

    return Obx(() {
      return _auth.isLogged.value
          ?  HomeScreenGetX()
          :  AuthScreenGetX();
    });
  }
}
