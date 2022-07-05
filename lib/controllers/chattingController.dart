import 'package:frontend/controllers/userController.dart';
import 'package:frontend/services/chattingService.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/chatMessageResponseModel.dart';
import 'checkTokenController.dart';

class ChattingController extends GetxController {
  final userStorage = Get.find<CheckTokenController>();
  final getUserP = Get.find<UserController>();
  ChattingService chattingService = ChattingService();
  var getChatMessage = ChatMessageResponseModel();

  get sendByMe => getUserP.getUserProfile.upId;
  String reactiveCrId = "no data";
  String reactiveCrName = "no data";
  RxString reactiveCrImg = "no data".obs;
  final RxString loading = "not yet".obs;
  late RxString resultIcon1 = "0".obs;
  late RxString resultIcon2 = "0".obs;
  late RxInt count = 0.obs;


  @override
  void onInit() {
    //resultIcon.value = ["0"];
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> loadingChatMessage() async {
    resultIcon1.value = "0";
    resultIcon2.value = "0";
    count.value = 0;
    loading("loading");
    //dialogLoading();
    //await Future.delayed(const Duration(seconds: 2));
    //final callApi = Get.find<LocationService>();
    //var locationList = await callApi.getLocationCallApi();

    var charMessageList =
        await chattingService.getChatMessageCallApi(reactiveCrId);
    if (chattingService.statusCode == 200) {
      // for (int i = 0; i < locationList['result'].length; i++) {
      getChatMessage = ChatMessageResponseModel.fromJson(charMessageList);
      print('${getChatMessage.result!.length}');
      print('$sendByMe');
      print('${getChatMessage.result![0].cmUserProfileId}');
      print('${getChatMessage.result![0].upName}');
      print('${getChatMessage.result![0].upImage}');
      print('${getChatMessage.result![4].upName}');
      print('${getChatMessage.result![4].upImage}');
      // print('${getChatMessage.value.result![0].cmCreated}');
      // print('${getChatMessage.value.result![0].cmMessage}');
      // print('${getChatMessage.value.result![1].cmCreated}');
      // print('${getChatMessage.value.result![1].cmMessage}');
      // print('${getChatMessage.value.result![2].cmCreated}');
      // print('${getChatMessage.value.result![2].cmMessage}');
      // print('${getChatMessage.value.result![2].cmCreated!.year}');
      // print('${getChatMessage.value.result![3].cmCreated}');
      // print('${getChatMessage.value.result![3].cmMessage}');
      //result.addAll(getChatMessage.result!);
      //var date = getChatMessage.result![1].cmCreated;
      //DateTime dateTime1 = DateFormat("yyyy-MM-dd hh:mm:ss").parse(getChatMessage.result![0].cmCreated!);
      //DateTime dateTime2 = DateFormat("yyyy-MM-dd ").parse(getChatMessage.result![0].cmCreated!);
      //String ddd1 =  DateFormat.Hms().format(getChatMessage.result![0].cmCreated!);
      //String ddd2 =  DateFormat.yMMM().format(getChatMessage.result![0].cmCreated!);
      //print(ddd1);
      //print(ddd2);
      //}
      loading("compile");
      return;
      //print('${ChatRoomResponseModel.fromJson(charRoomList).result?[0].crId}');
      //print('${locationList['result'][0]}');
      //print('${getChatRoom.result?[1].crId}');

    }
    loading("not yet");
  }
}
