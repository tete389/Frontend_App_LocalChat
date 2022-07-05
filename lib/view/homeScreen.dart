import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/view/chatHomeScreen.dart';
import 'package:frontend/view/profileScreen.dart';

import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.sendState}) : super(key: key);

  final int sendState;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentState = widget.sendState;

  final screens = [
    const Center(
      child: Text('1'),
    ),
    const Center(
      child: ChatHomeScreen(),
    ),
    // const Center(
    //   child: Text('3'),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentState],
      bottomNavigationBar: bottomNavigationBar1(),
    );
  }

  Widget bottomNavigationBar1() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          gradient: linerGradientCustomTheme2(
            CustomTheme.demiPrimaryTheme,
            CustomTheme.primaryTheme,
          )),
      child: BottomNavigationBar(
        iconSize: 30.0,
        elevation: 0.0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
        //showSelectedLabels: false,
        //showUnselectedLabels: false,
        //selectedFontSize: 16,
        //unselectedFontSize: 12,
        selectedLabelStyle: textWorkSansSemiBold_16(),
        backgroundColor: Colors.transparent,
        currentIndex: currentState,
        onTap: (index) => setState(() => currentState = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidCompass),
              //activeIcon: Icon(FontAwesomeIcons.solidCompass),
              label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidComments),
            //activeIcon: Icon(FontAwesomeIcons.solidComments),
            label: 'Chat',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(FontAwesomeIcons.solidUser),
          //   activeIcon: Icon(FontAwesomeIcons.solidUser),
          //   label: 'Profile',
          // ),
        ],
      ),
    );
  }
}
