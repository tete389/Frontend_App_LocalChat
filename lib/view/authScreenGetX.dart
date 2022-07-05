import 'package:flutter/material.dart';
import 'package:frontend/services/authService.dart';
import 'package:frontend/controllers/checkTokenController.dart';
import 'package:frontend/controllers/authPageController.dart';
import 'package:frontend/view/loginWindow.dart';
import 'package:frontend/view/registerWindow.dart';
import 'package:frontend/view/theme/customTheme.dart';
import 'package:get/get.dart';

import 'loginWindowGetX.dart';
import 'painter/customPainter.dart';
import 'registerWindowGetX.dart';
import 'widgets/widget.dart';

class AuthScreenGetX extends StatelessWidget {
  AuthScreenGetX({Key? key}) : super(key: key);

  //final ap = Get.put(AuthApiController());
  //final authState = Get.find<AuthPageController>();
  final authState = Get.put(AuthPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: boxDecorationCustomTheme(
                CustomTheme.demiPrimaryTheme, CustomTheme.primaryTheme),
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  image(context),
                  menuBar(),
                  windowLoginAndRegister(context),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget image(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 75.0),
      child: Image(
        height: MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
        fit: BoxFit.fill,
        image: const AssetImage('assets/imgs/logo-1.png'),
      ),
    );
  }

  Widget menuBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: 300.0,
        height: 50.0,
        decoration: boxDecorationButtonRC25(),
        child: CustomPaint(
          painter: BubbleIndicatorPainter(
              pageController: authState.pageController.value),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: textButtonMenuBar(authState.left.value, "LOGIN", 0),
              ),
              Expanded(
                child: textButtonMenuBar(authState.right.value, "REGISTER", 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textButtonMenuBar(Color _color, String text, int _page) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () => onButtonPress(_page),
      child: Text(
        text,
        style: TextStyle(
            color: _color, fontSize: 16.0, fontFamily: 'WorkScanSemiBold'),
      ),
    );
  }

  void onButtonPress(int page) {
    authState.pageController.value.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  Widget windowLoginAndRegister(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: authState.pageController.value,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (int i) {
          authState.resetPage();
          FocusScope.of(context).requestFocus(FocusNode());
          if (i == 0) {
            authState.switchLeft();
          } else if (i == 1) {
            authState.switchRight();
          }
        },

        /// window
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: LoginWindowGetX(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: RegisterWindowGetX(),
          ),
        ],
      ),
    );
  }
}
