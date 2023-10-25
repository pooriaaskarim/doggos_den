import 'package:flutter/material.dart';

class AppPageTransitionsTheme extends PageTransitionsTheme {
  AppPageTransitionsTheme()
      : super(
          builders: {
            TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
          },
        );
}
