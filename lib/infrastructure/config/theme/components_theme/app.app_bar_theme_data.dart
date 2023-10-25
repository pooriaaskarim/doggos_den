import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app.sizes.dart';
import '../app.elevations.dart';
import '../app.fonts.dart';

class AppAppbarThemeData extends AppBarTheme {
  AppAppbarThemeData.from(final ColorScheme colorScheme)
      : super(
          actionsIconTheme: IconThemeData(color: colorScheme.onBackground),
          color: Colors.transparent,
          elevation: AppElevations.level_0,
          scrolledUnderElevation: AppElevations.level_2,
          foregroundColor: colorScheme.onBackground,
          iconTheme: IconThemeData(
            color: colorScheme.onBackground,
            size: AppSizes.points_24,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: colorScheme.brightness,
            statusBarIconBrightness:
                (colorScheme.brightness == Brightness.light)
                    ? Brightness.dark
                    : Brightness.light,
          ),
          surfaceTintColor: colorScheme.surfaceTint,
          toolbarHeight: AppSizes.points_48,
          titleTextStyle: AppFonts.textTheme.titleLarge?.merge(
            TextStyle(
              color: colorScheme.onBackground,
            ),
          ),
        );
}
