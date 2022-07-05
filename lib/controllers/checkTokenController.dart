import 'package:frontend/controllers/homeScreenController.dart';
import 'package:frontend/controllers/locationController.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/authService.dart';
import 'authPageController.dart';

class CheckTokenController extends GetxController with CacheManager {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    Get.delete<HomeScreenController>();
    Get.delete<LocationController>();
    removeToken();
  }

  void login(String? token) async {
    if(token != null){
      //Token is cached
      isLogged.value = true;
      await saveToken(token);
    }
  }


  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }
}

enum CacheManagerKey { TOKEN }
