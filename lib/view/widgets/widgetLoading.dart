import 'package:flutter/material.dart';
import 'package:frontend/view/theme/customTheme.dart';

Center mainLoading(Color bgc) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children:  <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(backgroundColor: bgc, color: CustomTheme.secondaryTheme,),
        ),
        const Text('Loading...'),
      ],
    ),
  );
}
