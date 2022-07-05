import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/controllers/checkTokenController.dart';
import 'package:frontend/view/splashView.dart';
import 'package:frontend/view/widgets/onboardWidget.dart';
import 'package:get/get.dart';

import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class ProfileScreenGetX extends StatelessWidget {
  const ProfileScreenGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: CustomTheme.primaryTheme,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: [
            Text(
              "My Info",
              style: textWorkSansBold_25Primary(),
            ),
          ],
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: CustomTheme.white,
        // flexibleSpace: Container(
        //   decoration: boxDecorationCustomTheme(
        //     CustomTheme.loginGradientEnd2,
        //     CustomTheme.loginGradientEnd,
        //   ),
        // ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.all(60.0),
                decoration: BoxDecoration(
                  color: CustomTheme.loginGradientEnd2,
                  borderRadius: BorderRadius.circular(75.0),
                ),
                child: const Icon(FontAwesomeIcons.user),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "ออกจากระบบ",
                      titleStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                      middleText: "ยืนยันการออกจากระบบ",
                      middleTextStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      textCancel: "ยกเลิก",
                      cancelTextColor: CustomTheme.primaryTheme,
                      textConfirm: "ยันยืน",
                      confirmTextColor: CustomTheme.white,
                      onConfirm: (){
                        Get.find<CheckTokenController>().logOut();
                        Get.back(canPop: true,closeOverlays: true);
                      },
                      buttonColor: CustomTheme.primaryTheme
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          color: CustomTheme.primaryTheme,
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Icon(FontAwesomeIcons.signOut),
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
