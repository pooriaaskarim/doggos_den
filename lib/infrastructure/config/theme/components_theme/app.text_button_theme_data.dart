import 'package:flutter/material.dart';

import '../../../utils/app.sizes.dart';
import '../../../utils/app.utils.dart';
import '../app.elevations.dart';
import '../app.fonts.dart';
import '../app.opacities.dart';

class AppTextButtonThemeData extends TextButtonThemeData {
  AppTextButtonThemeData(final ColorScheme colorScheme)
      : super(
          style: ButtonStyle(
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
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return AppElevations.level_0;
                }
                if (states.any(
                  {
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return AppElevations.level_2;
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
            shape: const MaterialStatePropertyAll(
              ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppUtils.borderRadius)),
              ),
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
          ),
        );

  static ButtonStyle surfaceStyle(final ColorScheme colorScheme) =>
      AppTextButtonThemeData(colorScheme).style!.copyWith(
            backgroundColor: MaterialStatePropertyAll(colorScheme.surface),
            elevation: MaterialStateProperty.resolveWith<double?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return AppElevations.level_0;
                }
                if (states.any(
                  {
                    MaterialState.focused,
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return AppElevations.level_0;
                }
                // pressed and enabled states
                return AppElevations.level_0;
              },
            ),
            iconColor: MaterialStatePropertyAll(colorScheme.onSurface),
            textStyle: MaterialStatePropertyAll(AppFonts.textTheme.labelLarge),
            // shadowColor: MaterialStatePropertyAll(
            //   colorScheme.shadow,
            // ),
          );

  static ButtonStyle elevatedStyle(final ColorScheme colorScheme) =>
      AppTextButtonThemeData(colorScheme).style!.copyWith(
            backgroundColor: MaterialStatePropertyAll(colorScheme.background),
            elevation: MaterialStateProperty.resolveWith<double?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return AppElevations.level_1;
                }
                if (states.any(
                  {
                    MaterialState.focused,
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return AppElevations.level_4;
                }
                // pressed and enabled states
                return AppElevations.level_3;
              },
            ),
            iconColor: MaterialStatePropertyAll(colorScheme.onSurface),
            textStyle: MaterialStatePropertyAll(AppFonts.textTheme.labelLarge),
            shadowColor: MaterialStatePropertyAll(
              colorScheme.shadow,
            ),
          );

  static ButtonStyle elevatedErrorStyle(final ColorScheme colorScheme) =>
      AppTextButtonThemeData(colorScheme).style!.copyWith(
            backgroundColor: MaterialStatePropertyAll(colorScheme.error),
            elevation: MaterialStateProperty.resolveWith<double?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return AppElevations.level_1;
                }
                if (states.any(
                  {
                    MaterialState.focused,
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return AppElevations.level_4;
                }
                // pressed and enabled states
                return AppElevations.level_3;
              },
            ),
            iconColor: MaterialStatePropertyAll(colorScheme.onError),
            textStyle: MaterialStatePropertyAll(AppFonts.textTheme.labelLarge),
            shadowColor: MaterialStatePropertyAll(
              colorScheme.shadow,
            ),
          );

  static ButtonStyle tertiaryStyle(final ColorScheme colorScheme) =>
      AppTextButtonThemeData(colorScheme).style!.copyWith(
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
                return colorScheme.tertiary;
              },
            ),
            elevation: MaterialStateProperty.resolveWith<double?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return AppElevations.level_2;
                }
                //focused, pressed, disabled and enabled states
                return AppElevations.level_0;
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return colorScheme.onSurface.withOpacity(38 / 100);
                }
                if (states.any(
                  {
                    MaterialState.pressed,
                  }.contains,
                )) {
                  return colorScheme.tertiary
                      .withOpacity(AppOpacities.pressStateLayerOpacity);
                }
                //Any State other than disabled
                return null;
              },
            ),
            textStyle: MaterialStatePropertyAll(AppFonts.textTheme.labelLarge),
            shadowColor: MaterialStatePropertyAll(
              colorScheme.shadow,
            ),
          );
}
