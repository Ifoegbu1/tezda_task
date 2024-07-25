import 'package:flutter/material.dart';
import 'package:tezda_task/utils/app_colors.dart';

ThemeData darkTheme = ThemeData.dark();
ThemeData lightTheme = ThemeData.light();

ThemeData appDarkTheme = darkTheme.copyWith(
  // primaryColor: ,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black12,
  ),
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: AppColors.lightBlue,
    // onPrimary: AppColors.white,
    // onSurface: Colors.grey.shade900,

    // secondary: AppColors.black,
    // onSecondary: Color.fromRGBO(30, 30, 30, 1),
    // error: AppColors.red,
    // onError: Color.fromRGBO(235, 87, 87, 0.5),
    // background: AppColors.white,
    // onBackground: Color.fromRGBO(240, 240, 240, 1),
    // surface: Color.fromRGBO(248, 251, 255, 1),
    // onSurface: Color.fromRGBO(248, 248, 248, 1),
  ),
);

ThemeData appLightTheme = lightTheme.copyWith(
  // brightness: Brightness.dark,
  // useMaterial3: false,
  // Customize appBar exxperience
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),

  primaryColor: Colors.white,

  // // inputDecorationTheme: const InputDecorationTheme(suffixIconColor: null),
  // iconButtonTheme: const IconButtonThemeData(
  //   style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.black54)),
  // ),
  // iconTheme: const IconThemeData(color: Colors.black),
  // scaffoldBackgroundColor: Colors.white,
  // Provides the full theme data object for more complex needs
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: AppColors.lightBlue,

    // surface: Color.fromRGBO(248, 251, 255, 1),
    // onSurface: Color.fromRGBO(248, 248, 248, 1),
  ),
  // Define the various text styles used through the app
);
