import 'package:flutter/material.dart';

import '../../../utils/app.sizes.dart';
import '../app.elevations.dart';
import '../app.fonts.dart';

class AppTextButtonThemeData extends TextButtonThemeData {
  AppTextButtonThemeData(final ColorScheme colorScheme)
      : super(
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            foregroundColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            overlayColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            shadowColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                vertical: AppSizes.points_12,
                horizontal: AppSizes.points_16,
              ),
            ),
            elevation: MaterialStateProperty.resolveWith<double?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.hovered,
                    MaterialState.focused,
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return AppElevations.level_0;
                }
                //focused, pressed and enabled states
                return AppElevations.level_1;
              },
            ),
            textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (final states) {
                final TextStyle? textStyle = AppFonts.textTheme.labelLarge;
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return textStyle?.merge(
                    TextStyle(
                      color: colorScheme.onSurface.withOpacity(38 / 100),
                    ),
                  );
                }
                //Any State other than disabled
                return textStyle?.merge(
                  TextStyle(
                    color: colorScheme.onBackground,
                  ),
                );
              },
            ),
            iconColor: MaterialStateProperty.resolveWith<Color?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return colorScheme.onSurface.withOpacity(38 / 100);
                }
                //Any State other than disabled
                return colorScheme.primary;
              },
            ),
            side:
                MaterialStateProperty.resolveWith<BorderSide?>((final states) {
              if (states.any(
                {
                  MaterialState.hovered,
                }.contains,
              )) {
                return BorderSide(color: colorScheme.primary, width: 1);
              }
              if (states.any(
                {
                  MaterialState.pressed,
                  MaterialState.selected,
                  MaterialState.dragged,
                }.contains,
              )) {
                return BorderSide(color: colorScheme.primary, width: 4);
              } else {
                return null;
              }
            }),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                (final states) {
              if (states.any(
                {
                  MaterialState.hovered,
                }.contains,
              )) {
                return LinearBorder.bottom(
                  side: BorderSide(color: colorScheme.primary, width: 1),
                );
              }
              if (states.any(
                {
                  MaterialState.pressed,
                  MaterialState.selected,
                  MaterialState.dragged,
                }.contains,
              )) {
                return LinearBorder.bottom(
                  side: BorderSide(color: colorScheme.primary, width: 2),
                );
              } else {
                return const ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppSizes.points_0)),
                );
              }
            }),
          ),
        );
}
