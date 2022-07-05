import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/controllers/homeScreenController.dart';
import 'package:frontend/controllers/locationController.dart';
import 'package:frontend/services/locationService.dart';
import 'package:frontend/view/chatSearchScreenGetX.dart';
import 'package:frontend/view/mapScreen.dart';
import 'package:frontend/view/test2.dart';
import 'package:get/get.dart';

import '../controllers/userController.dart';
import 'chatHomeScreen.dart';
import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class HomeScreenGetX extends StatelessWidget {
  HomeScreenGetX({Key? key}) : super(key: key);

  final controller = Get.put(HomeScreenController());
  final userInstall = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => SafeArea(
            child: IndexedStack(
              index: controller.tabIndex.value,
              children: [
                MapScreen(),
                ChatSearchScreenGetX(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: BoxDecoration(
                // borderRadius: const BorderRadius.only(
                //   topRight: Radius.circular(10),
                //   topLeft: Radius.circular(10),
                // ),
              border: Border.all(
                color: CustomTheme.black
              ),
                gradient: linerGradientCustomTheme3(
                  CustomTheme.primaryTheme,
                  CustomTheme.demiPrimaryTheme,
                  CustomTheme.primaryTheme,
                )),
            child: BottomNavigationBar(
              iconSize: 30.0,
              elevation: 0.0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black45,
              selectedLabelStyle: textWorkSansSemiBold_16(),
              backgroundColor: Colors.transparent,
              currentIndex: controller.tabIndex.value,
              onTap: (index) {
                controller.changeTabIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidCompass),
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidComments),
                  label: 'Chat',
                ),
              ],
            ),
          ),
        ));
  }

  // _bottomNavigationBarItem({IconData? icon, String? label}) {
  //   return BottomNavigationBarItem(
  //     icon: Icon(icon),
  //     label: label,
  //   );
  // }
}
