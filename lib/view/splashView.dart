import 'package:flutter/material.dart';
import 'package:frontend/controllers/checkTokenController.dart';
import 'package:get/get.dart';

import 'widgets/onboardWidget.dart';
import 'widgets/widget.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  final CheckTokenController _authController = Get.put(CheckTokenController());
  //final CheckTokenController _authController = Get.find<CheckTokenController>();

  Future<void> initializeSettings() async {
    _authController.checkLoginStatus();

    //Simulate other services for 3 seconds
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            return const OnBoardWidget();
          }
        }
        return Material(
          child: circularProgress(),
        );
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
