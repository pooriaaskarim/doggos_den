import 'package:flutter/material.dart';

class AppOutlinedButtonThemeData extends OutlinedButtonThemeData {
  AppOutlinedButtonThemeData.from(
    final ColorScheme colorScheme,
  ) : super(
          style: OutlinedButton.styleFrom(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(
              color: colorScheme.primaryContainer,
            ),
          ),
        );

  static ButtonStyle tertiaryStyle(final ColorScheme colorScheme) =>
      OutlinedButton.styleFrom(
        side: BorderSide(
          color: colorScheme.tertiary,
        ),
      );

  static ButtonStyle errorStyle(final ColorScheme colorScheme) =>
      OutlinedButton.styleFrom(
        side: BorderSide(
          color: colorScheme.error,
        ),
      );

  static ButtonStyle primaryContainerStyle(final ColorScheme colorScheme) =>
      OutlinedButton.styleFrom(
        side: BorderSide(
          color: colorScheme.primaryContainer,
        ),
      );
}
