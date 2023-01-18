import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      titleSpacing: 20,
      actionsIconTheme: IconThemeData(
          color: Colors.black
      ),
      color: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),
      titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20
      )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      color: Colors.blueGrey,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  fontFamily: 'Jannah',
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.blueGrey[900],
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      actionsIconTheme: const IconThemeData(
          color: Colors.white
      ),
      color:Colors.blueGrey[900],
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blueGrey[900],
          statusBarIconBrightness: Brightness.light
      ),
      titleTextStyle: const TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: Colors.blueGrey[900],

  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  fontFamily: 'Jannah',
);