import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/authRequrstModel.dart';
import '../controllers/authValidation.dart';
import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class RegisterWindow extends StatefulWidget {
  const RegisterWindow({Key? key}) : super(key: key);

  @override
  State<RegisterWindow> createState() => _RegisterWindowState();
}

class _RegisterWindowState extends State<RegisterWindow> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  final formKey = GlobalKey<FormState>();
  //AuthModel authSignUp = AuthModel();


  /// ObscureText
  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerValid = Provider.of<AuthValidation>(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  // card background
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      width: 300.0,
                      height: 360.0,
                      child: Column(
                        children: <Widget>[
                          textBoxName(providerValid),
                          lineUnderText(),
                          textBoxEmail(providerValid),
                          lineUnderText(),
                          textBoxPassword(providerValid),
                          lineUnderText(),
                          textBoxPasswordConfirm(providerValid),
                        ],
                      ),
                    ),
                  ),
                  /// Button Sign up
                  buttonSignUp(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget textBoxName(validationService) {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(FontAwesomeIcons.user,
              size: 22.0,
              color: (validationService.name.error == null
                  ? Colors.black
                  : Colors.red)),
          hintText: 'Name',
          hintStyle: textWorkSansSemiBold_16(),
        ),
        onChanged: (value) {
          validationService.changeName(value);
        },
        onSaved: (name) {
          //authSignUp.name = name;
        },
      ),
    );
  }

  Widget textBoxEmail(validationService) {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(FontAwesomeIcons.envelope,
              size: 22.0,
              color: (validationService.email.error == null
                  ? Colors.black
                  : Colors.red)),
          hintText: 'Email Address',
          hintStyle: textWorkSansSemiBold_16(),
        ),
        onChanged: (value) {
          validationService.changeEmail(value);
        },
        onSaved: (email) {
          //authSignUp.email = email;
        },
      ),
    );
  }

  Widget textBoxPassword(validationService) {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        obscureText: _obscureTextPassword,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(FontAwesomeIcons.lock,
              color: (validationService.password.error == null
                  ? Colors.black
                  : Colors.red)),
          hintText: 'Password',
          hintStyle: textWorkSansSemiBold_16(),
          suffixIcon: GestureDetector(
            onTap: _toggleSignup,
            child: Icon(
              _obscureTextPassword
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        onChanged: (value) {
          validationService.changePassword(value);
        },
        onSaved: (password) {
          //authSignUp.password = password;
        },
      ),
    );
  }

  Widget textBoxPasswordConfirm(validationService) {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        obscureText: _obscureTextConfirmPassword,
        autocorrect: false,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(FontAwesomeIcons.lock,
              color: (validationService.confirmPassword.error == null
                  ? Colors.black
                  : Colors.red)),
          hintText: 'Confirmation',
          hintStyle: textWorkSansSemiBold_16(),
          suffixIcon: GestureDetector(
            onTap: _toggleSignupConfirm,
            child: Icon(
              _obscureTextConfirmPassword
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        onChanged: (value) {
          validationService.changeConfirmPassword(value);
        },
        textInputAction: TextInputAction.go,
      ),
    );
  }


  Widget buttonSignUp(){
    return Container(
      margin: const EdgeInsets.only(top: 340.0),
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
        onPressed: (null),
      ),
    );
  }
}
