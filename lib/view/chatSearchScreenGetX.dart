import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/controllers/chatSearchController.dart';
import 'package:frontend/controllers/locationController.dart';
import 'package:frontend/models/chatRoomResponseModel.dart';
import 'package:frontend/models/locationResponseModel.dart';
import 'package:frontend/view/chattingScreen.dart';
import 'package:frontend/view/profileScreenGetX.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../controllers/chattingController.dart';
import '../services/configs/configImageUrl.dart';
import 'profileScreen.dart';
import 'theme/customTheme.dart';
import 'widgets/widget.dart';
import 'widgets/widgetLoading.dart';

class ChatSearchScreenGetX extends StatelessWidget {
  ChatSearchScreenGetX({Key? key}) : super(key: key);

  final _chatSearch = Get.put(ChatSearchController());
  final locationSearch = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomTheme.bronze,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: IconButton(
                  onPressed: () => {
                        Get.to(() => const ProfileScreenGetX()),
                      },
                  icon: const Icon(FontAwesomeIcons.user)),
            ),
            const SizedBox(width: 10.0),
            const Text(
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: CustomTheme.backGroundTheme,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10.0,
            ),
            searchLoading(context),
            const SizedBox(
              height: 10.0,
            ),
            areaSearch(context),
            const SizedBox(
              height: 5,
            ),
            listChatSearch(context),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////
  Widget listChatSearch(context) {
    return Obx(
      () => Expanded(
        child: Container(
          alignment: Alignment.topCenter,
          //padding: const EdgeInsets.symmetric(horizontal: 24),
          //margin: EdgeInsets.symmetric(horizontal: 24),
          //color: CustomTheme.backGroundTheme,
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
          child: _chatSearch.searching.value == "compile"
              ? GroupedListView<ResultChatRoom, String>(
                  padding: const EdgeInsets.only(bottom: 8),
                  useStickyGroupSeparators: true,
                  floatingHeader: true,
                  elements: _chatSearch.getChatRoom.resultChatRoom!,
                  groupBy: (element) {
                    return element.crLocationId!;
                  },
                  groupHeaderBuilder: (result) => groupHeader(result),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.crId!.compareTo(item2.crId!),
                  //order: GroupedListOrder.DESC,
                  // groupSeparatorBuilder: (String value) {
                  //   String? d = "0";
                  //   for (int it = 0;
                  //       it < locationSearch.getLocation.result!.length;
                  //       it++) {
                  //     if (value ==
                  //         locationSearch.getLocation.result![it].ldId) {
                  //       d = locationSearch.getLocation.result![it].ldName;
                  //     }
                  //   }
                  //   return Padding(
                  //     padding: const EdgeInsets.all(8),
                  //     child: Text(
                  //       "${d}",
                  //       textAlign: TextAlign.center,
                  //       style: const TextStyle(
                  //         color: CustomTheme.rust,
                  //           fontSize: 15, fontWeight: FontWeight.w600),
                  //     ),
                  //   );
                  // },
                  itemBuilder: (context, result) {
                    return listChat(
                      result.crName,
                      result.crImage,
                      result.crId,
                    );
                  },
                )
              : mainLoading(CustomTheme.primaryTheme),
          // _chatSearch.notFound.value
          //         ? _chatSearch.notYetSearch.value
          //             ? notYetSearch()
          //             : _chatSearch.loading.value
          //                 ? isLoading()
          //                 : _chatSearch.notConnectApi.value
          //                     ? notConnect()
          //                     : notFoundChat()
          //         : Container()

          // GetBuilder<ChatSearchController>(
          //         builder: (snapshot) {
          //           return ListView.builder(
          //             padding: EdgeInsets.zero,
          //             itemCount: _chatSearch.getChatRoom.result!.length,
          //             shrinkWrap: true,
          //             physics: const ClampingScrollPhysics(),
          //             itemBuilder: (context, index) {
          //               return listChat(
          //                 index,
          //                 snapshot.getChatRoom.result?[index].crName,
          //                 snapshot.getChatRoom.result?[index].crImage,
          //                 snapshot.getChatRoom.result?[index].crId,
          //               );
          //             },
          //           );
          //         },
          //       );
        ),
      ),
    );
  }

  Widget containerRowLine(Color start, Color end) {
    return Container(
      decoration: boxDecorationCustomTheme(start, end),
      width: 60.0,
      height: 1.0,
    );
  }

  Widget containerRowLineLeft(Color start, Color end) {
    return Container(
      decoration: boxDecorationCustomTheme(start, end),
      //width: 100.0,
      height: 1.0,
    );
  }

  Widget groupHeader(ResultChatRoom result) {
    String? locationName = "0";
    for (ResultLocation count in locationSearch.getLocation.result!) {
      if (result.crLocationId == count.ldId) {
        locationName = count.ldName;
      }
    }

    // for (int it = 0;
    // it < locationSearch.getLocation.result!.length;
    // it++) {
    //   if (result.crLocationId ==
    //       locationSearch.getLocation.result![it].ldId) {
    //     d = locationSearch.getLocation.result![it].ldName;
    //   }
    // }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: containerRowLineLeft(CustomTheme.primaryTheme, CustomTheme.burntOrange)),
        // const Expanded(
        //   child: SizedBox(
        //     height: 1,
        //   ),
        // ),
        Expanded(
          child: Card(
            color: CustomTheme.rust,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "$locationName",
                softWrap: false,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: CustomTheme.white, fontSize: 15),
              ),
            ),
          ),
        ),
        // const Expanded(
        //   child: SizedBox(
        //     height: 1,
        //   ),
        // ),
         Expanded(child: containerRowLine(CustomTheme.burntOrange, CustomTheme.primaryTheme)),
      ],
    );
  }

  Widget areaSearch(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      //color: CustomTheme.backGroundTheme,
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 1 / 10,
      height: 80,
      child: Stack(
        children: <Widget>[
          Stack(
            children: [
              Container(
                //alignment: Alignment.topRight,
                //padding: const EdgeInsets.all(20.0),
                // padding: EdgeInsets.only(
                //     right:
                //         MediaQuery.of(context).size.width * 7.4 / 10),
                decoration: BoxDecoration(
                  color: CustomTheme.primaryTheme,
                  borderRadius: BorderRadius.circular(45.0),
                ),
                width: MediaQuery.of(context).size.width * 5 / 10,
                //height: MediaQuery.of(context).size.height* 1/11,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 3.7 / 5,
                    bottom: MediaQuery.of(context).size.height * 1 / 30),
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
                    right: MediaQuery.of(context).size.width * 3.7 / 5),
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(left: 88),
            decoration: const BoxDecoration(
              color: CustomTheme.demiPrimaryTheme,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _chatSearch.itemsArea.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                // return Obx(() {
                return GetBuilder<ChatSearchController>(builder: (snapshot) {
                  return pickArea(
                      snapshot.itemsArea[index]["itemsArea"], index);
                });
                // });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget searchLoading(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width * 9.5 / 10,
      height: MediaQuery.of(context).size.height * 0.6 / 10,
      decoration: BoxDecoration(
        color: CustomTheme.demiPrimaryTheme,
        borderRadius: radius45(),
      ),
      child: GestureDetector(
        onTap: (null),
        child: Container(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.005,
              top: MediaQuery.of(context).size.height * 0.005),
          child: Row(
            children: <Widget>[
              const Center(
                child: Text(
                  "ค้นหาห้องแชทในระยะ",
                  style: TextStyle(
                    color: CustomTheme.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              GetBuilder<ChatSearchController>(builder: (snapshot) {
                return Center(
                  child: (snapshot.loading.value
                      ? spinnerKitCir()
                      : iconGlassLocation()),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius radius45() {
    return const BorderRadius.all(Radius.circular(45));
  }

  Widget pickArea(String itemArea, int index) {
    return InkWell(
      onTap: () => _chatSearch.toggleArea(index),
      child: Row(
        children: [
          Container(
            //margin: EdgeInsets.only(top: 3,bottom: 3),
            padding: const EdgeInsets.only(
                top: 24.0, bottom: 24.0, right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: (_chatSearch.isToggleArea[index]
                  ? CustomTheme.primaryTheme
                  : CustomTheme.demiPrimaryTheme),
            ),
            child: Text(
              itemArea + " เมตร",
              style: const TextStyle(
                  color: CustomTheme.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          (_chatSearch.itemsArea.length - 1) == index
              ? const SizedBox(
                  width: 0,
                )
              : const SizedBox(
                  width: 15,
                )
        ],
      ),
    );
  }

  Widget notFoundChat() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 26.5),
      child: const Text(
        "ไม่พบห้องแชทในบริเวณนี้",
        style: TextStyle(
            color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget isLoading() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 26.5),
      child: const Text(
        "กำลังค้นหาห้องแชทใยระยะ",
        style: TextStyle(
            color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget notConnect() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 26.5),
      child: const Text(
        "ไม่มีการเชื่อมต่ออินเตอร์เน็ต",
        style: TextStyle(
            color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget notYetSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 26.5),
      child: const Text(
        "เลือกระยะ เพื่อค้นหาห้องแชท",
        style: TextStyle(
            color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget listChat(String? name, String? image, String? crId) {
    return GestureDetector(
      onTap: () {
        if (crId!.isNotEmpty) {
          _chatSearch.infoChatMessage(crId, name!, image!);
          Get.to(() => ChattingScreen());
        }
      },
      child: Container(
        //width: 70,
        //height: 70,
        //color: Colors.black,
        //padding: EdgeInsets.all( 16.0),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: image == "no data"
                  ? Container(
                      width: 70,
                      height: 70,
                      color: CustomTheme.primaryTheme,
                      child: const Icon(
                        FontAwesomeIcons.streetView,
                        size: 50,
                        color: CustomTheme.backGroundTheme,
                      ),
                    )
                  : Image.network(
                      '${ConfigImageUrl.imageChatRoom}$image',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name!,
                    softWrap: false,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            // const Spacer(),
            // Container(
            //   width: 70,
            //   height: 70,
            //   //color: CustomTheme.primaryTheme,
            //   child: const Icon(
            //     FontAwesomeIcons.circleArrowRight,
            //     size: 50,
            //     color: CustomTheme.primaryTheme,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
