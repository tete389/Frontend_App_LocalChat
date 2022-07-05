
import 'package:frontend/models/userProfileResponseModel.dart';
import 'package:frontend/services/userService.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController{

  UserService userService = UserService();
  UserProfileResponseModel getUserProfile = UserProfileResponseModel();

  RxBool loading = false.obs;

  @override
  void onInit() {
    loadingUserProfile();
    super.onInit();
  }


  Future<void> loadingUserProfile() async {
    loading(true);
    //dialogLoading();
    //await Future.delayed(const Duration(seconds: 2));
    //final callApi = Get.find<LocationService>();
    //var locationList = await callApi.getLocationCallApi();

    var userProfile = await userService.getUserCallApi();
    if (userService.statusCode == 200) {
      // for (int i = 0; i < locationList['result'].length; i++) {
      getUserProfile = UserProfileResponseModel.fromJson(userProfile);
      print('${getUserProfile.upId}');
      //}
    }

    print('${getUserProfile.upId}');
    loading(false);
  }
}