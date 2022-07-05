import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/authRequrstModel.dart';
import '../controllers/authValidation.dart';
import 'theme/customTheme.dart';
import 'widgets/widget.dart';

class LoginWindow extends StatefulWidget {
  const LoginWindow({Key? key}) : super(key: key);

  @override
  State<LoginWindow> createState() => _LoginWindowState();
}

class _LoginWindowState extends State<LoginWindow> {
  bool _obscureTextPassword = true;

  final formKey = GlobalKey<FormState>();
  //AuthModel authSignIn = AuthModel();

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerValid = Provider.of<AuthValidation>(context);
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SizedBox(
                    width: 300.0,
                    height: 190.0,
                    child: Column(
                      children: <Widget>[
                        /// Text
                        textBoxEmail(providerValid),
                        lineUnderText(),
                        textBoxPassword(providerValid),
                      ],
                    ),
                  ),
                ),
                /// button login
                buttonLogin(),
              ],
            ),

            /// -Or-
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  containerRowLine(Colors.white10, Colors.white),
                  textOr(),
                  containerRowLine(Colors.white, Colors.white10),
                ],
              ),
            ),

            /// Google login
            Padding(
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
            ),
          ],
        ),
      ),
    );
  }



  Widget textBoxEmail(validationService) {
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.envelope,
            size: 22.0,
            color: (validationService.email.error == null
                ? Colors.black
                : Colors.red),
          ),
          hintText: 'Email Address',
          hintStyle: textWorkSansSemiBold_17(),
        ),
        onChanged: (value) {
          validationService.changeEmail(value);
        },
        onSaved: (email) {
          //authSignIn.email = email;
        },
      ),
    );
  }


  Widget textBoxPassword(validationService){
    return Padding(
      padding: paddingCard(),
      child: TextFormField(
        obscureText: _obscureTextPassword,
        style: textWorkSansSemiBold_16Black(),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.lock,
            size: 22.0,
            color: (validationService.password.error == null
                ? Colors.black
                : Colors.red),
          ),
          hintText: 'Password',
          hintStyle: textWorkSansSemiBold_17(),
          suffixIcon: GestureDetector(
            onTap: _toggleLogin,
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
          //authSignIn.password = password;
        },
        textInputAction: TextInputAction.go,
      ),
    );
  }


  Widget buttonLogin(){
    return Container(
      margin: const EdgeInsets.only(top: 170.0),
      decoration: boxDecorationButtonRC5(),
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: CustomTheme.loginGradientEnd,
        child: Padding(
          padding: edgeInsetsSymmetric10v_42h(),
          child: Text(
            'SIGN IN',
            style: textWorkSansBold_25white(),
          ),
        ),
        onPressed: (null),
        // onPressed: () => CustomSnackBar(
        //   context,
        //   const Text('Login button pressed'),
        // ),
      ),
    );
  }

  Widget containerRowLine(Color start, Color end){
    return Container(
      decoration: boxDecorationCustomTheme(start, end),
      width: 100.0,
      height: 1.0,
    );
  }

  Widget textOr(){
    return Padding(
      padding: edgeInsetsOnly15l_15r(),
      child: Text(
        'Or',
        style: textWorkSansMedium_16white(),
      ),
    );
  }
}
