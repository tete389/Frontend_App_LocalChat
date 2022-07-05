import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/view/chatRoomScreen.dart';
import 'package:frontend/view/profileScreen.dart';

import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  int _itemCount = 0;
  late bool _itemCountLimit;
  late bool _notItemCount;

  late bool scanItem;

  @override
  void initState() {
    super.initState();
    if (_itemCount <= 6) {
      _itemCountLimit = true;
      _notItemCount = false;
    } else {
      _itemCountLimit = false;
    }
    if (_itemCount <= 0) {
      _notItemCount = true;
    }
  }

  bool _obscure = true;

  void _toggle() {
    setState(() {
      _obscure = !_obscure;
      _itemCount++;
      if (_itemCount <= 6) {
        _itemCountLimit = true;
        _notItemCount = false;
      } else {
        _itemCountLimit = false;
      }
      if (_itemCount <= 0) {
        _notItemCount = true;
      }
    });
  }

  void _toggleR() {
    setState(() {
      _obscure = !_obscure;
      _itemCount--;
      if (_itemCount <= 6) {
        _itemCountLimit = true;
      } else {
        _itemCountLimit = false;
      }
      if (_itemCount <= 0) {
        _notItemCount = true;
      }
    });
  }

  void _toggleArea(int index) {
    setState(() {
      for (int i = 0; i < _isToggleArea.length; i++) {
        _isToggleArea[i] = false;
      }
      _isToggleArea[index] = true;
    });
  }

  static final List<String> _itemsArea = ['10', '20', '30', '40', '50'];

  static final List<bool> _isToggleArea = [true, false, false, false, false];

  String? selectedItem = 'item 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                )
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: CustomTheme.bronze,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Icon(FontAwesomeIcons.user),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              "แชท",
              style: TextStyle(
                  color: CustomTheme.bronze,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: CustomTheme.backGroundTheme,
        // flexibleSpace: Container(
        //   decoration: boxDecorationCustomTheme(
        //     Color(0xFFFD6A02),
        //     Color(0xFFFD6A02),
        //   ),
        // ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: CustomTheme.backGroundTheme,
        // decoration: boxDecorationCustomTheme(
        //   CustomTheme.primaryTheme,
        //   CustomTheme.demiPrimaryTheme,
        // ),
        //color: Colors.white12,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              //const Padding(padding: EdgeInsets.only(top: 50.0)),
              // const SizedBox(height: 50.0),
              //
              const SizedBox(height: 10.0),
              // Card(
              //   elevation: 2.0,
              //   color: Colors.white,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0),
              //   ),
              //   child: SizedBox(
              //     width: 350.0,
              //     height: 50.0,
              //     child: Row(
              //       children: <Widget>[
              //         /// Text
              //         const Text(
              //           'ค้นหาแชทที่อยู๋ใกล้เคียง',
              //           style: TextStyle(
              //             color: Colors.black87,
              //             fontSize: 25,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         const Spacer(),
              //
              //         Container(
              //             padding: const EdgeInsets.all(10),
              //             decoration: BoxDecoration(
              //                 color: const Color(0xff444446),
              //                 borderRadius: BorderRadius.circular(12)),
              //             child: GestureDetector(
              //               onTap: _toggle,
              //               child: Icon(
              //                 _obscure
              //                     ? FontAwesomeIcons.magnifyingGlassLocation
              //                     : FontAwesomeIcons.magnifyingGlass,
              //                 color: Colors.white,
              //               ),
              //             ))
              //       ],
              //     ),
              //   ),
              // ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: MediaQuery.of(context).size.width * 0.96,
                height: MediaQuery.of(context).size.height * 0.055,
                decoration: BoxDecoration(
                  color: CustomTheme.demiPrimaryTheme,
                  borderRadius: fff(),
                  //(_itemCountLimit ? fff() : ggg()),
                ),
                child: GestureDetector(
                  onTap: _toggle,
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.005,
                        top: MediaQuery.of(context).size.height * 0.005),
                    //color: Colors.black,
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              "ค้นหาห้องแชทในระยะ",
                              style: TextStyle(
                                color: CustomTheme.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Center(
                                child: (_obscure
                                    ? iconGlassLocation()
                                    : spinnerKitCir()))
                            //

                            // Icon(
                            //   _obscure
                            //       ? FontAwesomeIcons.magnifyingGlassLocation
                            //       : FontAwesomeIcons.magnifyingGlass,
                            //   color: Colors.black45,
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                color: CustomTheme.backGroundTheme,
                //width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1 / 10,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          //alignment: Alignment.topRight,
                          //padding: const EdgeInsets.all(20.0),
                          padding: EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width * 3.7 / 5),
                          decoration: BoxDecoration(
                            color: CustomTheme.primaryTheme,
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          width: MediaQuery.of(context).size.width * 1 / 5,
                          //height: MediaQuery.of(context).size.height* 1/11,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width * 3.7 / 5,
                              bottom:
                                  MediaQuery.of(context).size.height * 1 / 30),
                          // padding:
                          //     const EdgeInsets.only(top: 12.0, left: 23.0),
                          // decoration: BoxDecoration(
                          //   color: CustomTheme.primaryTheme,
                          //   borderRadius: BorderRadius.circular(45.0),
                          // ),
                          child: const Icon(
                            FontAwesomeIcons.locationDot,
                            color: CustomTheme.white,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width * 3.7 / 5),
                          // decoration: BoxDecoration(
                          //   color: CustomTheme.primaryTheme,
                          //   borderRadius: BorderRadius.circular(45.0),
                          // ),
                          child: spinnerKitRipple(),
                        ),
                      ],
                    ),
                    Container(
                      //color: CustomTheme.burntOrange,
                      padding: EdgeInsets.only(left: 10, right: 5),
                      margin: EdgeInsets.only(left: 88),
                      decoration: BoxDecoration(
                        color: CustomTheme.demiPrimaryTheme,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return bbb(_itemsArea[index], index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 24),
                //margin: EdgeInsets.symmetric(horizontal: 24),
                color: CustomTheme.backGroundTheme,
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height * 0.7,
                // decoration: BoxDecoration(
                //   color: CustomTheme.backGroundTheme,
                //   borderRadius: fff(),
                // border: Border.all(
                //   color: CustomTheme.primaryTheme,
                //   width: 1,
                //
                // )
                //(_itemCountLimit ? fff() : ggg()),
                //),
                child: Column(
                  children: [
                    (_notItemCount
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 26.5),
                            child: Text(
                              "ไม่พบห้องแชทในบริเวณนี้",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _itemCount,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return aaa();
                            },
                          )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius fff() {
    return BorderRadius.all(Radius.circular(45));
  }

  BorderRadius ggg() {
    return BorderRadius.only(
        topLeft: Radius.circular(30), topRight: Radius.circular(30));
  }

  // Widget bbb2(String item, int index) {
  //   return ElevatedButton(
  //     onPressed: () => _toggleArea(index),
  //     child: Container(
  //       //margin: EdgeInsets.only(top: 3,bottom: 3),
  //       padding: EdgeInsets.only(top: 24.0, bottom: 24.0, right: 10, left: 10),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         color: (_isToggleArea[index]
  //             ? CustomTheme.primaryTheme
  //             : CustomTheme.demiPrimaryTheme),
  //       ),
  //       child: Text(
  //         item + " เมตร",
  //         style: TextStyle(
  //             color: CustomTheme.white,
  //             fontSize: 16,
  //             fontWeight: FontWeight.w600),
  //       ),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       primary: CustomTheme.demiPrimaryTheme,
  //     )
  //   );
  // }

  Widget bbb(String item, int index) {
    return InkWell(
      onTap: () => _toggleArea(index),
      child: Row(
        children: [
          Container(
            //margin: EdgeInsets.only(top: 3,bottom: 3),
            padding:
                EdgeInsets.only(top: 24.0, bottom: 24.0, right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: (_isToggleArea[index]
                  ? CustomTheme.primaryTheme
                  : CustomTheme.demiPrimaryTheme),
            ),
            child: Text(
              item + " เมตร",
              style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget aaa() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomScreen(
              token: '1234',
            ),
          ),
        );
        //_toggleR();
      },
      child: Container(
        //color: Colors.black,
        //padding: EdgeInsets.all( 16.0),
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(45),
            //   child: const Icon(FontAwesomeIcons.user),
            // ),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //color: Colors.black54,
                  border:
                      Border.all(width: 0.5, color: CustomTheme.primaryTheme)),
              child: const Icon(
                FontAwesomeIcons.user,
                //color: Color(0xFF0084ff),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "name",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "lastMessage",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontFamily: "Neue Haas Grotesk"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget kkk() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.24,
      child: DropdownButtonFormField(
          items: _itemsArea
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
              .toList(),
          onChanged: (e) => setState(() {
                selectedItem = e as String?;
              })),
    );
  }
}
