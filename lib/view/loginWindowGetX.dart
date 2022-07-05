import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/services/authService.dart';
import 'package:frontend/controllers/checkTokenController.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/authPageController.dart';
import '../models/authRequrstModel.dart';
import '../controllers/authValidation.dart';
import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class LoginWindowGetX extends StatelessWidget {
  LoginWindowGetX({Key? key}) : super(key: key);

  final authState = Get.find<AuthPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Form(
        key: authState.formKeyLogin,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  child: Obx(() {
                    // if (authApi.loading.value) {
                    //   // Get.defaultDialog(
                    //   //   title: 'Loading',
                    //   //   middleText: 'Loading',
                    //   // );
                    //   return const Center(child: CircularProgressIndicator());
                    // }
                    // if (authApi.statusCode.value != 200) {
                    //   Get.snackbar(
                    //     "Login Report Status",
                    //     'authApi',
                    //     icon: const Icon(Icons.person, color: Colors.white),
                    //     snackPosition: SnackPosition.BOTTOM,
                    //     backgroundColor: CustomTheme.warningSnackBar2,
                    //     colorText: CustomTheme.white,
                    //   );
                    // }

                    return Column(
                      children: <Widget>[
                        textBoxEmail(),
                        lineUnderText(),
                        textBoxPassword(),
                        spaceRow15(),
                        buttonLogin(),
                      ],
                    );
                  }),
                ),
              ),
            ),
            textOrUnderBoxText(),
            googleLogin(),
          ],
        ),
      ),
    );
  }

  Widget textBoxEmail() {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        controller: authState.emailLogin,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(FontAwesomeIcons.envelope,
              size: 22.0, color: Colors.black),
          hintText: 'Email Address',
          hintStyle: textWorkSansSemiBold_17(),
        ),
        // onChanged: (value) {
        //   //authState.changeEmail(value);
        // },
        onSaved: (value) {
          authState.loginRequest.email = value!;
        },
        validator: (value) {
          return authState.validateEmailLogin(value!);
        },
      ),
    );
  }

  Widget textBoxPassword() {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        controller: authState.passwordLogin,
        obscureText: authState.obscureTextPasswordLogin.value,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(FontAwesomeIcons.lock,
              size: 22.0, color: Colors.black),
          hintText: 'Password',
          hintStyle: textWorkSansSemiBold_17(),
          suffixIcon: GestureDetector(
            onTap: authState.toggleIconPasswordLogin,
            child: Icon(
              authState.obscureTextPasswordLogin.value
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        // onChanged: (value) {
        //   //authState.changePassword(value);
        // },
        onSaved: (value) {
          authState.loginRequest.password = value!;
        },
        validator: (value) {
          return authState.validatePasswordLogin(value!);
        },
      ),
    );
  }

  Widget buttonLogin() {
    return Container(
      //margin: const EdgeInsets.only(top: 170.0),
      decoration: boxDecorationButtonRC5(),
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: CustomTheme.primaryTheme,
        child: Padding(
          padding: edgeInsetsSymmetric10v_42h(),
          child: Text(
            'SIGN IN',
            style: textWorkSansBold_25white(),
          ),
        ),
        onPressed: () {
          //authState.openAndCloseLoadingDialog();
          authState.checkLogin();
        },
      ),
    );
  }

  Widget containerRowLine(Color start, Color end) {
    return Container(
      decoration: boxDecorationCustomTheme(start, end),
      width: 100.0,
      height: 1.0,
    );
  }

  Widget textOrUnderBoxText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          containerRowLine(Colors.white10, Colors.white),
          Padding(
            padding: edgeInsetsOnly15l_15r(),
            child: Text(
              'Or',
              style: textWorkSansMedium_16white(),
            ),
          ),
          containerRowLine(Colors.white, Colors.white10),
        ],
      ),
    );
  }

  Widget googleLogin() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        // onTap: () => CustomSnackBar(
        //     context, const Text('Google button pressed')),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(
            FontAwesomeIcons.google,
            color: Color(0xFF0084ff),
          ),
        ),
      ),
    );
  }
}
