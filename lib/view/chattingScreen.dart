import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/controllers/chattingController.dart';
import 'package:frontend/view/widgets/widgetDistance.dart';
import 'package:frontend/view/widgets/widgetLoading.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../controllers/checkTokenController.dart';
import '../models/chatMessageResponseModel.dart';
import '../services/configs/configImageUrl.dart';
import 'theme/customTheme.dart';

class ChattingScreen extends StatelessWidget {
  ChattingScreen({Key? key}) : super(key: key);
  final chatMessage = Get.find<ChattingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: CustomTheme.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                //borderRadius: const BorderRadius.all(Radius.circular(45)),
                // border: Border.all(
                //   width: 2,
                //   color: CustomTheme.rust,
                // ),
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: chatMessage.reactiveCrImg.value == "no data"
                    ? const SizedBox(
                        width: 40,
                        height: 40,
                        //color: CustomTheme.primaryTheme,
                        child: Icon(
                          FontAwesomeIcons.solidCommentDots,
                          size: 30,
                          color: CustomTheme.backGroundTheme,
                        ),
                      )
                    : Image.network(
                        '${ConfigImageUrl.imageChatRoom}${chatMessage.reactiveCrImg.value}',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            w15(),
            Text(
              chatMessage.reactiveCrName,
            ),
          ],
        ),
        backgroundColor: CustomTheme.primaryTheme,
      ),
      body: Obx(() {
        late String str = "0";
        return Column(
          children: [
            Expanded(
              child: chatMessage.loading.value == "compile"
                  ? GroupedListView<Result, DateTime>(
                      padding: const EdgeInsets.all(8),
                      reverse: true,
                      order: GroupedListOrder.DESC,
                      useStickyGroupSeparators: true,
                      floatingHeader: true,
                      elements: chatMessage.getChatMessage.result!,
                      groupBy: (result) => dt(result),
                      groupHeaderBuilder: (result) => groupHeader(result),
                      itemBuilder: (context, result) {
                        final bool isMe =
                            (chatMessage.sendByMe == result.cmUserProfileId!);
                        final bool isSameUser =
                            (str == result.cmUserProfileId!);
                        str = result.cmUserProfileId!;

                        return Padding(
                          padding: !isSameUser
                              ? const EdgeInsets.only(
                                  bottom: 12,
                                  left: 5,
                                  right: 5,
                                )
                              : const EdgeInsets.only(left: 5, right: 5),
                          child: isMe
                              ? messageByMe(result, isSameUser)
                              : messageByOther(result, isSameUser),
                        );
                      },
                    )
                  : mainLoading(CustomTheme.primaryTheme),
            ),

            // todo
            /////// send message
            Container(
              color: Colors.grey.shade200,
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'You message..',
                ),
                onSubmitted: (text) {
                  // final message = Result(
                  //   cmCreated: DateTime.now(),
                  //   cmUserProfileId:
                  // );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget messageByOther(Result result, bool isSameUser) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !isSameUser
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(45),
                          ),
                          border: Border.all(
                            width: 2,
                            color: CustomTheme.rust,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: result.upImage == "No Data"
                              ? Container(
                                  width: 40,
                                  height: 40,
                                  color: CustomTheme.primaryTheme,
                                  child: const Icon(
                                    FontAwesomeIcons.solidUser,
                                    size: 30,
                                    color: CustomTheme.backGroundTheme,
                                  ),
                                )
                              : Image.network(
                                  '${ConfigImageUrl.imageUserProfile}${result.upImage}',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    )
                  : w54(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: isSameUser
                          ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              side:
                                  BorderSide(color: CustomTheme.secondaryTheme),
                            )
                          : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              side:
                                  BorderSide(color: CustomTheme.secondaryTheme),
                            ),
                      color: CustomTheme.white,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        //// message
                        child: Text(
                          result.cmMessage!,
                          softWrap: false,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: CustomTheme.primaryTheme,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              w10(),
              Text(
                DateFormat.Hm().format(result.cmCreated!),
                style: const TextStyle(color: Colors.black45),
              ),
            ],
          ),
          !isSameUser
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // crossAxisAlignment:
                    //     CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(result.upName! + "  (" + result.upStatus! + ")"),
                    ],
                  ),
                )
              : const SizedBox(
                  width: 10,
                ),
        ],
      ),
    );
  }

  Widget messageByMe(Result result, bool isSameUser) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                DateFormat.Hm().format(result.cmCreated!),
                style: const TextStyle(color: Colors.black45),
              ),
              w10(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      shape:
                          // isSameUser
                          //     ? const RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.only(
                          //           topLeft: Radius.circular(15),
                          //           bottomLeft: Radius.circular(15),
                          //         ),
                          //       )
                          //     :
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      color: CustomTheme.primaryTheme,
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          //// message
                          result.cmMessage!,
                          softWrap: false,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: CustomTheme.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // !isSameUser
              //     ? Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Container(
              //           padding: const EdgeInsets.all(1),
              //           decoration: BoxDecoration(
              //             borderRadius: const BorderRadius.all(
              //               Radius.circular(45),
              //             ),
              //             border: Border.all(
              //               width: 2,
              //               color: CustomTheme.rust,
              //             ),
              //           ),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(45),
              //             child: result.upImage == "No Data"
              //                 ? Container(
              //                     width: 40,
              //                     height: 40,
              //                     color: CustomTheme.primaryTheme,
              //                     child: const Icon(
              //                       FontAwesomeIcons.solidUser,
              //                       size: 30,
              //                       color: CustomTheme.backGroundTheme,
              //                     ),
              //                   )
              //                 : Image.network(
              //                     '${ConfigImageUrl.imageUserProfile}${result.upImage}',
              //                     height: 40,
              //                     width: 40,
              //                     fit: BoxFit.cover,
              //                   ),
              //           ),
              //         ),
              //       )
              //     : const SizedBox(
              //         width: 54,
              //       ),
            ],
          ),
          !isSameUser
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // crossAxisAlignment:
                    //     CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(result.upName! + "  (" + result.upStatus! + ")"),
                      w10(),
                    ],
                  ),
                )
              : w10(),
        ],
      ),
    );
  }

  DateTime dt(Result result) {
    return DateTime(
      result.cmCreated!.year,
      result.cmCreated!.month,
      result.cmCreated!.day,
    );
  }

  Container groupHeader(Result result) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        height: 40,
        child: Center(
          child: Card(
            color: CustomTheme.demiPrimaryTheme,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                //DateFormat.yMMMd().format(result.cmCreated!),
                result.cmCreated!.day.toString() +
                    " " +
                    DateFormat.MMM().format(result.cmCreated!) +
                    ", " +
                    result.cmCreated!.year.toString(),
                style: const TextStyle(color: CustomTheme.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bbb(bool isSameUser, bool isMe, Result result) {
    return Padding(
      padding: !isSameUser
          ? const EdgeInsets.only(bottom: 24.0, left: 5, right: 5)
          : const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          !isSameUser
              ? !isMe
                  ? Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(45)),
                          border: Border.all(
                            width: 2,
                            color: CustomTheme.rust,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: result.upImage == "No Data"
                            ? Container(
                                width: 40,
                                height: 40,
                                color: CustomTheme.primaryTheme,
                                child: const Icon(
                                  FontAwesomeIcons.solidUser,
                                  size: 30,
                                  color: CustomTheme.backGroundTheme,
                                ),
                              )
                            : Image.network(
                                '${ConfigImageUrl.imageUserProfile}${result.upImage}',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                      ),
                    )
                  : Container()
              : const SizedBox(
                  width: 46,
                  //height: 40,
                ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Card(
                  color: isMe ? CustomTheme.primaryTheme : CustomTheme.white,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      result.cmMessage!,
                      softWrap: false,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: isMe
                              ? CustomTheme.white
                              : CustomTheme.primaryTheme,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                ),
                !isSameUser
                    ? Text(result.upName! + "  (" + result.upStatus! + ")")
                    : Container(),
              ],
            ),
          ),
          !isSameUser
              ? isMe
                  ? Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(45)),
                          border: Border.all(
                            width: 2,
                            color: CustomTheme.rust,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: result.upImage == "No Data"
                            ? Container(
                                width: 40,
                                height: 40,
                                color: CustomTheme.primaryTheme,
                                child: const Icon(
                                  FontAwesomeIcons.solidUser,
                                  size: 30,
                                  color: CustomTheme.backGroundTheme,
                                ),
                              )
                            : Image.network(
                                '${ConfigImageUrl.imageUserProfile}${result.upImage}',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                      ),
                    )
                  : Container()
              : w46(),
        ],
      ),
    );
  }
}
