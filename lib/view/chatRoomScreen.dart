import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/view/theme/customTheme.dart';

import 'chatWindow.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return ChatRoom2();
  }

  // Widget ChatRoom1() {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               SizedBox(
  //                 height: 90,
  //               ),
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(60),
  //                 child: const Icon(
  //                   FontAwesomeIcons.user,
  //                   size: 90,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 14,
  //               ),
  //               Text(
  //                 "------ชื่อสถานที่-------",
  //                 style: TextStyle(
  //                   color: CustomTheme.rust,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 4,
  //               ),
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 24),
  //                 child: ListView.builder(
  //                     itemCount: 6,
  //                     shrinkWrap: true,
  //                     physics: const ClampingScrollPhysics(),
  //                     itemBuilder: (context, index) {
  //                       return ChatWindow(
  //                         massage: 'test1',
  //                         sendByMe: true,
  //                       );
  //                     }),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           alignment: Alignment.bottomLeft,
  //           //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
  //           width: MediaQuery.of(context).size.width,
  //           child: Container(
  //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //             decoration: BoxDecoration(
  //               color: Colors.black54,
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: TextFormField(
  //                     //controller: ,
  //                     style: TextStyle(
  //                       color: CustomTheme.primaryTheme,
  //                     ),
  //                     decoration: InputDecoration(
  //                         hintText: " Massage",
  //                         hintStyle: TextStyle(color: CustomTheme.white),
  //                         border: InputBorder.none),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 16,
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {},
  //                   child: Container(
  //                     height: 40,
  //                     width: 40,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(40)),
  //                     padding: EdgeInsets.all(6),
  //                     child: Icon(
  //                       FontAwesomeIcons.locationArrow,
  //                       size: 30,
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget ChatRoom2() {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 90,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: const Icon(
                  FontAwesomeIcons.user,
                  size: 90,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "------ชื่อสถานที่-------",
                style: TextStyle(
                  color: CustomTheme.rust,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 120),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: ListView.builder(
                      itemCount: 6,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatWindow(
                          massage: 'test1',
                          sendByMe: true,
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  //controller: ,
                  style: TextStyle(
                    color: CustomTheme.primaryTheme,
                  ),
                  decoration: InputDecoration(
                      hintText: " Massage",
                      hintStyle: TextStyle(color: CustomTheme.white),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                  ),
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 30,
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
