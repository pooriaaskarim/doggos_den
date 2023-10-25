import 'package:flutter/material.dart';

import '../../../utils/app.sizes.dart';
import '../app.elevations.dart';

class AppSearchBarThemeData extends SearchBarThemeData {
  AppSearchBarThemeData.from(
    final ColorScheme colorScheme,
  ) : super(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppSizes.points_8, vertical: 0),
          ),
          constraints: const BoxConstraints(maxHeight: AppSizes.points_48),
          elevation: const MaterialStatePropertyAll(AppElevations.level_0),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              side: BorderSide(
                color: colorScheme.outline.withOpacity(0.4),
              ),
            ),
          ),
        );
}
