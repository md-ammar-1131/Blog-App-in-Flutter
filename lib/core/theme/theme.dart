//this will have app app thems in one dart file in common
import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    //this square braces is for default color;
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(10),
  );
  static final darkthemeMode = ThemeData.dark().copyWith(
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
