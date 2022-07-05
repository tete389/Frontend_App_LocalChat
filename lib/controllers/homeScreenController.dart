
import 'package:frontend/controllers/locationController.dart';
import 'package:get/get.dart';

import '../services/locationService.dart';

class HomeScreenController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    //Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<LocationController>(() => LocationController());
    // Get.put(LocationService());
    // Get.put(LocationController());
    super.onInit();
  }
}