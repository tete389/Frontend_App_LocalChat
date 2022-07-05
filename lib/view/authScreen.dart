import 'package:flutter/material.dart';
import 'package:frontend/view/loginWindow.dart';
import 'package:frontend/view/registerWindow.dart';
import 'package:frontend/view/theme/customTheme.dart';

import 'package:provider/provider.dart';

import '../controllers/authValidation.dart';
import 'painter/customPainter.dart';
import 'widgets/widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthValidation(),
      child: FutureBuilder(
        future: (null),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.hasError}"),
            );
          }
          if (snapshot.data == null) {
            final providerValid = Provider.of<AuthValidation>(context);
            return Scaffold(
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: boxDecorationCustomTheme(
                        CustomTheme.demiPrimaryTheme,
                        CustomTheme.primaryTheme),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        image(),
                        menuBar(),
                        windowLoginAndRegister(providerValid),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Material(
            child: circularProgress(),
          );
        },
      ),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.only(top: 75.0),
      child: Image(
        height: MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
        fit: BoxFit.fill,
        image: const AssetImage('assets/imgs/logo-1.png'),
      ),
    );
  }

  Widget menuBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: 300.0,
        height: 50.0,
        decoration: boxDecorationButtonRC25(),
        child: CustomPaint(
          painter: BubbleIndicatorPainter(pageController: _pageController),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: textButtonMenuBar(left, "LOGIN", 0),
              ),
              Expanded(
                child: textButtonMenuBar(right, "REGISTER", 1),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget textButtonMenuBar(Color _color, String text, int _page) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () => onButtonPress(_page),
      child: Text(
        text,
        style: TextStyle(
            color: _color, fontSize: 16.0, fontFamily: 'WorkScanSemiBold'),
      ),
    );
  }

  void onButtonPress(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  Widget windowLoginAndRegister(providerValid) {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (int i) {
          providerValid.resetValid();
          FocusScope.of(context).requestFocus(FocusNode());
          if (i == 0) {
            setState(() {
              right = Colors.white;
              left = Colors.black;
            });
          } else if (i == 1) {
            setState(() {
              right = Colors.black;
              left = Colors.white;
            });
          }
        },

        /// window
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: const LoginWindow(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: const RegisterWindow(),
          ),
        ],
      ),
    );
  }


}
