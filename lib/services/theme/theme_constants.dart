import 'package:flutter/material.dart';
import 'package:realtime_communication_app/config/color_config.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: ColorConfig.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(ColorConfig.primary), // Button color
            foregroundColor:
                MaterialStateProperty.all(Colors.white), // Text color
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))))),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorConfig.primary,
      foregroundColor: Colors.white, // Text color
    ));
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: ColorConfig.primary,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(ColorConfig.primary), // Button color
        foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
  ),
);
