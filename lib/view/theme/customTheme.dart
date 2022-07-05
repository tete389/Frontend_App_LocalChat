
import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme();

  static const Color loginGradientStart = Color.fromARGB(255, 231, 76, 29);
  static const Color loginGradientEnd = Color.fromARGB(255, 231, 112, 142);
  static const Color loginGradientStart2 = Color(0xff4338CA);
  static const Color loginGradientEnd2 = Color(0xff6D28D9);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color night = Color(0xFF0C090A);

  static const Color burntOrange = Color(0xFF602800);
  static const Color rust = Color(0xFF8B4000);
  static const Color bronze = Color(0xFFB1560F);

  static const Color warningSnackBar = Color(0xFFBF360C);
  static const Color warningSnackBar2 = Color(0xFFD84315);

  static const Color primaryTheme = Color(0xFFFD6A02);
  static const Color demiPrimaryTheme = Color(0xFFFDA50F);
  static const Color secondaryTheme = Color(0xFFC0C0C0);
  static const Color demiSecondaryTheme = Color(0xFBD5D5D5);
  static const Color backGroundTheme = Color(0xFFEEEEEE);


  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}