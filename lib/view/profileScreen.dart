//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/myAppTest.dart';

import 'homeScreen.dart';
import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            Navigator.pop(
              context,

            );
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: boxDecorationCustomTheme(
          CustomTheme.primaryTheme,
          CustomTheme.demiPrimaryTheme,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 115,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.43,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: ggg(),
                  //(_itemCountLimit ? fff() : ggg()),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15.0),
                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.all(10.0),
                    //       decoration: BoxDecoration(
                    //         color: CustomTheme.loginGradientEnd2,
                    //         borderRadius: BorderRadius.circular(12.0),
                    //       ),
                    //       child: const Icon(FontAwesomeIcons.user),
                    //     ),
                    //     const SizedBox(width: 10.0),
                    //     Text(
                    //       "Profile",
                    //       style: textWorkSansBold_25black(),
                    //     ),
                    //   ],
                    // ),
                    //const SizedBox(height: 25.0),
                    Container(
                      //alignment: Alignment.center,
                      padding: const EdgeInsets.all(60.0),
                      decoration: BoxDecoration(
                        color: CustomTheme.loginGradientEnd2,
                        borderRadius: BorderRadius.circular(75.0),
                      ),
                      child: const Icon(FontAwesomeIcons.user),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "--- ชื่อที่ใช้แสดงในห้อง ---",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius ggg() {
    return BorderRadius.only(
        bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30));
  }
}
