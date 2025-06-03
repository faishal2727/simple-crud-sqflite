import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.strokeLine]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
      );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.white,
    appBarTheme: const AppBarTheme(
      color: AppPallete.white,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.primaryColor),
      errorBorder: _border(AppPallete.red),
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.primaryColor),
      labelStyle: TextStyle(color: AppPallete.white),
      side: BorderSide.none,
    ),
  );
}
