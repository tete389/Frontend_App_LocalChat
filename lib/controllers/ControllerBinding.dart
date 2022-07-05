
import 'package:frontend/services/authService.dart';
import 'package:frontend/controllers/authPageController.dart';
import 'package:frontend/controllers/checkTokenController.dart';
import 'package:frontend/controllers/locationController.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    //Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    //Get.lazyPut<CheckTokenController>(() => CheckTokenController());
    Get.lazyPut<AuthPageController>(() => AuthPageController());
   // Get.lazyPut<AuthService>(() => AuthService());
  }

}