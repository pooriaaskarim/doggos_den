import 'package:flutter/material.dart';

import '../../../utils/app.sizes.dart';
import '../../../utils/app.utils.dart';
import '../app.fonts.dart';

class AppInputDecorationData extends InputDecorationTheme {
  AppInputDecorationData.from(final ColorScheme colorScheme)
      : super(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.points_16,
            vertical: AppSizes.points_12,
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle: AppFonts.textTheme.bodyMedium
              ?.copyWith(color: colorScheme.outline),
          labelStyle: AppFonts.textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onBackground),
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorScheme.outline.withOpacity(0.4),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppUtils.borderRadius),
            ),
          ),
        );
}
