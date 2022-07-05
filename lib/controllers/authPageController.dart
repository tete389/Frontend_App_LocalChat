import 'package:flutter/material.dart';
import 'package:frontend/models/loginRequestModel.dart';
import 'package:frontend/models/registerRequestModel.dart';
import 'package:frontend/view/theme/customTheme.dart';
import 'package:get/get.dart';

import '../services/authService.dart';

class AuthPageController extends GetxController {
  final Rx<Color> left = Colors.black.obs;
  final Rx<Color> right = Colors.white.obs;
  final Rx<PageController> pageController = PageController().obs;
  final RxBool obscureTextPasswordLogin = true.obs;
  final RxBool obscureTextPasswordRegister = true.obs;
  final RxBool obscureTextConfirmPassword = true.obs;


  late TextEditingController emailLogin,
      passwordLogin,
      nameRegister,
      emailResister,
      passwordResister,
      confirmPasswordResister;

  final RegisterRequestModel registerRequest = RegisterRequestModel();
  final LoginRequestModel loginRequest = LoginRequestModel();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    emailLogin = TextEditingController();
    passwordLogin = TextEditingController();
    nameRegister = TextEditingController();
    emailResister = TextEditingController();
    passwordResister = TextEditingController();
    confirmPasswordResister = TextEditingController();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   formKeyLogin.currentState!.reset();
  //   formKeyRegister.currentState!.reset();
  //   nameRegister.clear();
  //   emailResister.clear();
  //   passwordResister.clear();
  //   emailLogin.clear();
  //   passwordLogin.clear();
  //   confirmPasswordResister.clear();
  // }

  /// function

  String? validateEmailLogin(String value) {
    if (value == "Admin" && passwordLogin.text == "Admin") {
      return null;
    }
    if (value.isEmpty) {
      return "กรุณากรอก Email";
    } else if (!GetUtils.isEmail(value)) {
      return "รูปแบบ Email ไม่ถูกต้อง";
    }
    return null;
  }

  String? validateEmailRegister(String value) {
    if (value.isEmpty) {
      return "กรุณากรอก Email";
    } else if (!GetUtils.isEmail(value)) {
      return "รูปแบบ Email ไม่ถูกต้อง";
    }
    return null;
  }

  String? validatePasswordLogin(String value) {
    if (value == "Admin" && emailLogin.text == "Admin") {
      return null;
    }
    if (value.length < 6) {
      return "password อย่างน้อย 6 ตัวอักษร";
    }
    return null;
  }

  String? validatePasswordRegister(String value) {
    if (value.length < 6) {
      return "password อย่างน้อย 6 ตัวอักษร";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.length < 3) {
      return "กรุณากรอกชื่อ อย่างน้อย 3 ตัวอักษร";
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value != passwordResister.text) {
      return "กรุณากรอก ConfirmPassword ให้ถูกต้อง";
    }
    return null;
  }

  void toggleIconPasswordLogin() {
    obscureTextPasswordLogin.value = !obscureTextPasswordLogin.value;
  }

  void toggleIconPasswordRegister() {
    obscureTextPasswordRegister.value = !obscureTextPasswordRegister.value;
  }

  void toggleIconConfirmPassword() {
    obscureTextConfirmPassword.value = !obscureTextConfirmPassword.value;
  }

  void switchLeft() {
    left.value = Colors.black;
    right.value = Colors.white;
  }

  void switchRight() {
    left.value = Colors.white;
    right.value = Colors.black;
  }

  void resetPage() {
    registerRequest.email = '';
    registerRequest.password = '';
    registerRequest.name = '';
    loginRequest.email = '';
    loginRequest.password = '';
  }


  ///// Check
  void checkLogin() {
    final isValid = formKeyLogin.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKeyLogin.currentState!.save();
    openAndCloseLoadingDialogLogin();
  }

  Future<void> openAndCloseLoadingDialogLogin() async {
    dialogLoading();
    //await Future.delayed(const Duration(seconds: 2));
    // final authApi = Get.find<AuthService>();
    // await authApi.loginCallApi();
    AuthService authService = AuthService();
    String authRes = await authService.loginCallApi();
    /// close dialog loading
    Navigator.of(Get.overlayContext!).pop();

    if (authRes == "timeOut") {
      diaLogTimeout();
    } else if (authRes == "auth.sign_in.fail") {
      diaLogNotFound();
    } else if(authRes != "200"){
      diaLogFail();
    }
  }

  ///
  void checkRegister() {
    final isValid = formKeyRegister.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKeyRegister.currentState!.save();
    openAndCloseLoadingDialogRegister();
  }

  Future<void> openAndCloseLoadingDialogRegister() async {
    dialogLoading();
    //await Future.delayed(const Duration(seconds: 2));
    // final authApi = Get.find<AuthService>();
    // await authApi.registerCallApi();
    AuthService authService = AuthService();
    String authRes = await authService.registerCallApi();
    /// close dialog loading
    Navigator.of(Get.overlayContext!).pop();

    if (authRes == "timeOut") {
      diaLogTimeout();
    } else if (authRes == "sign_up.fail.email.duplicate") {
      diaLogUserDuplicate();
    } else if(authRes != "200"){
      diaLogFail();
    }
  }


  /////// Dialog
  dialogLoading(){
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              color: CustomTheme.primaryTheme,
              strokeWidth: 10,
            ),
          ),
        ),
      ),
    );
  }

  diaLogTimeout(){
    Get.defaultDialog(
      title: "หมดเวลาเชื่อมต่อ",
      middleText: "กรุณาตรวจสอบการเชื่อมต่อ \n internet ของท่าน",
      textCancel: "CLOSE",
      cancelTextColor: CustomTheme.primaryTheme,
      buttonColor: CustomTheme.primaryTheme,
      barrierDismissible: false,
    );
  }

  diaLogNotFound(){
    Get.defaultDialog(
      title: "ไม่พบข้อมูล",
      middleText: "กรุณาตรวจสอบ \n Email และ Password ของท่านอีกครั้ง",
      textCancel: "CLOSE",
      cancelTextColor: CustomTheme.primaryTheme,
      buttonColor: CustomTheme.primaryTheme,
      barrierDismissible: false,
    );
  }

  diaLogFail(){
    Get.defaultDialog(
      title: "การเชื่อมต่อล้มเหลว",
      middleText: "กรุณาตรวจสอบข้อมูลของท่าน",
      textCancel: "CLOSE",
      cancelTextColor: CustomTheme.primaryTheme,
      buttonColor: CustomTheme.primaryTheme,
      barrierDismissible: false,
    );
  }

  diaLogUserDuplicate(){
    Get.defaultDialog(
      title: "บัญชีซ้ำ",
      middleText: "Email นี้ได้ถูกใช้งาน \n ในระบบแล้ว",
      textCancel: "CLOSE",
      cancelTextColor: CustomTheme.primaryTheme,
      buttonColor: CustomTheme.primaryTheme,
      barrierDismissible: false,
    );
  }

// void clearPage() {
  //   nameRegister.clear();
  //   emailLogin.clear();
  //   passwordLogin.clear();
  //   confirmPasswordResister.clear();
  //   obscureTextPasswordLogin.value = true;
  //   obscureTextPasswordRegister.value = true;
  //   obscureTextConfirmPassword.value = true;
  //   switchLeft();
  //   registerRequest.email = '';
  //   registerRequest.password = '';
  //   registerRequest.name = '';
  //   loginRequest.email = '';
  //   loginRequest.password = '';
  // }
}
