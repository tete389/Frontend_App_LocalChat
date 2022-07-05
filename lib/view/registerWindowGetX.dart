import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../services/authService.dart';
import '../controllers/checkTokenController.dart';
import '../controllers/authPageController.dart';
import '../models/authRequrstModel.dart';
import '../controllers/authValidation.dart';
import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class RegisterWindowGetX extends StatelessWidget {
  RegisterWindowGetX({Key? key}) : super(key: key);


  final authState = Get.find<AuthPageController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Form(
          key: authState.formKeyRegister,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                // card background
                child: Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SizedBox(
                    width: 300.0,
                    //height: 360.0,
                    child: Obx(
                      () => Column(
                        children: <Widget>[
                          textBoxName(),
                          lineUnderText(),
                          textBoxEmail(),
                          lineUnderText(),
                          textBoxPassword(),
                          lineUnderText(),
                          textBoxPasswordConfirm(),
                          spaceRow15(),
                          buttonSignUp(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textBoxName() {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        controller: authState.nameRegister,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(FontAwesomeIcons.user,
              size: 22.0, color: Colors.black),
          hintText: 'Name',
          hintStyle: textWorkSansSemiBold_16(),
        ),
        // onChanged: (value) {
        //   validationService.changeName(value);
        // },
        onSaved: (value) {
          authState.registerRequest.name = value!;
        },
        validator: (value) {
          return authState.validateName(value!);
        },
      ),
    );
  }

  Widget textBoxEmail() {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        controller: authState.emailResister,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(FontAwesomeIcons.envelope,
              size: 22.0, color: Colors.black),
          hintText: 'Email Address',
          hintStyle: textWorkSansSemiBold_16(),
        ),
        // onChanged: (value) {
        //   validationService.changeEmail(value);
        // },
        onSaved: (value) {
          authState.registerRequest.email = value!;
        },
        validator: (value) {
          return authState.validateEmailRegister(value!);
        },
      ),
    );
  }

  Widget textBoxPassword() {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        controller: authState.passwordResister,
        obscureText: authState.obscureTextPasswordRegister.value,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(FontAwesomeIcons.lock, size: 22.0, color: Colors.black),
          hintText: 'Password',
          hintStyle: textWorkSansSemiBold_16(),
          suffixIcon: GestureDetector(
            onTap: authState.toggleIconPasswordRegister,
            child: Icon(
              authState.obscureTextPasswordRegister.value
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        onSaved: (value) {
          authState.registerRequest.password = value!;
        },
        validator: (value) {
          return authState.validatePasswordRegister(value!);
        },
      ),
    );
  }

  Widget textBoxPasswordConfirm() {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        controller: authState.confirmPasswordResister,
        obscureText: authState.obscureTextConfirmPassword.value,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(FontAwesomeIcons.lock, size: 22.0, color: Colors.black),
          hintText: 'Confirmation',
          hintStyle: textWorkSansSemiBold_16(),
          suffixIcon: GestureDetector(
            onTap: authState.toggleIconConfirmPassword,
            child: Icon(
              authState.obscureTextConfirmPassword.value
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        validator: (value) {
          return authState.validateConfirmPassword(value!);
        },
      ),
    );
  }

  Widget buttonSignUp() {
    return Container(
      //margin: const EdgeInsets.only(top: 340.0),
      decoration: boxDecorationButtonRC5(),
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: CustomTheme.loginGradientEnd,
        child: Padding(
          padding: edgeInsetsSymmetric10v_42h(),
          child: Text(
            'SIGN UP',
            style: textWorkSansBold_25white(),
          ),
        ),
        onPressed: () {
          authState.checkRegister();
          // if (authState.registerRequest.email!.isNotEmpty &&
          //     authState.registerRequest.password!.isNotEmpty &&
          //     authState.registerRequest.name!.isNotEmpty) {
          //   Get.find<AuthApiController>().registerCallApi();
          //}
        },
      ),
    );
  }
}
