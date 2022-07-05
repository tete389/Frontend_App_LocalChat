import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/customTheme.dart';

BoxDecoration boxDecorationButtonRC25() {
  return const BoxDecoration(
    color: Color(0x552B2B2B),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  );
}

BoxDecoration boxDecorationButtonRC5() {
  return const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: CustomTheme.demiPrimaryTheme,
        offset: Offset(1.0, 6.0),
        blurRadius: 20.0,
      ),
      BoxShadow(
        color: CustomTheme.primaryTheme,
        offset: Offset(1.0, 6.0),
        blurRadius: 20.0,
      ),
    ],
    gradient: LinearGradient(
        colors: <Color>[
          CustomTheme.rust,
          CustomTheme.bronze,
        ],
        begin: FractionalOffset(0.2, 0.2),
        end: FractionalOffset(1.0, 1.0),
        stops: <double>[0.0, 1.0],
        tileMode: TileMode.clamp),
  );
}

// LinearGradient linearGradientCustomTheme() {
//   return const LinearGradient(
//       colors: <Color>[
//         CustomTheme.loginGradientStart2,
//         CustomTheme.loginGradientEnd2
//       ],
//       begin: FractionalOffset(0.0, 0.0),
//       end: FractionalOffset(1.0, 1.0),
//       stops: <double>[0.0, 1.0],
//       tileMode: TileMode.clamp);
// }

BoxDecoration boxDecorationCustomTheme(Color start, Color end) {
  return BoxDecoration(
    gradient: LinearGradient(
        colors: <Color>[
          start,
          end,
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 1.0),
        stops: const <double>[0.0, 1.0],
        tileMode: TileMode.clamp),
  );
}

LinearGradient linerGradientCustomTheme2(Color start, Color end){
  return LinearGradient(
      colors: <Color>[
        start,
        end,
      ],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 1.0),
      stops: const <double>[0.0, 1.0],
      tileMode: TileMode.clamp);
}

LinearGradient linerGradientCustomTheme3(Color start, Color mid, Color end){
  return LinearGradient(
      colors: <Color>[
        start,
        mid,
        end,
      ],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 1.0),
      stops: const <double>[0.0, 0.5, 1.0],
      tileMode: TileMode.clamp);
}


Widget lineUnderText() {
  return Container(
    width: 250.0,
    height: 1.0,
    color: Colors.grey[400],
  );
}

Widget spaceRow15(){
  return const SizedBox(
    height: 15,
  );
}

Widget lineUnderText2() {
  return Container(
    width: 300.0,
    height: 2.0,
    color: const Color(0xffbdbdbd),
  );
}

// List<String> items = ['10 เมตร','20 เมตร','30 เมตร','40 เมตร','50 เมตร'];
//
// String? selectedItem = 'item 1';

// Widget dropDownButton(){
//   return DropdownButtonFormField(items: items.map((item) => DropdownMenuItem<String>(value: item,child: Text(item),)).toList(), onChanged: (item) => setState(() => selectedItem = item));
// }

Widget spinnerKitCir(){
  return const SpinKitFadingCircle(
    color: CustomTheme.white,
    size: 30.0,
  );
}

Widget spinnerKitRipple(){
  return const SpinKitRipple(
    color: CustomTheme.white,
    size: 70.0,
  );
}


Widget iconGlassLocation(){
  return const Icon(
    FontAwesomeIcons.magnifyingGlassLocation,
    color: CustomTheme.white,
    size: 30.0,
  );
}

Widget circularProgress() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
      ],
    ),
  );
}

Widget circularProgressLowSize() {
  return const Center(
    child: CircularProgressIndicator(color: CustomTheme.loginGradientEnd2,),
  );
}

EdgeInsets edgeInsetsSymmetric10v_42h() {
  return const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0);
}

EdgeInsets edgeInsetsOnly15l_15r() {
  return const EdgeInsets.only(left: 15.0, right: 15.0);
}

TextStyle textWorkSansSemiBold_16Black() {
  return const TextStyle(
      fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black);
}

TextStyle textWorkSansSemiBold_16() {
  return const TextStyle(
    fontFamily: 'WorkSansSemiBold',
    fontSize: 16.0,
  );
}

TextStyle textWorkSansSemiBold_17() {
  return const TextStyle(
    fontFamily: 'WorkSansSemiBold',
    fontSize: 17.0,
  );
}

TextStyle textWorkSansBold_25white() {
  return const TextStyle(
      color: Colors.white, fontSize: 25.0, fontFamily: 'WorkSansBold');
}

TextStyle textWorkSansBold_25Primary() {
  return const TextStyle(
      color: CustomTheme.primaryTheme, fontSize: 25.0, fontFamily: 'WorkSansBold');
}

TextStyle textWorkSansBold_25black() {
  return const TextStyle(
      color: Colors.black54, fontSize: 25.0, fontFamily: 'WorkSansBold');
}


TextStyle textWorkSansMedium_16white() {
  return const TextStyle(
      color: Colors.white, fontSize: 16.0, fontFamily: 'WorkSansMedium');
}

EdgeInsets paddingCard() {
  return const EdgeInsets.only(
      top: 20.0, bottom: 20.0, left: 25.0, right: 25.0);
}

// void onSignUpButtonPress(PageController pageController) {
//   pageController.animateToPage(1,
//       duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
// }
