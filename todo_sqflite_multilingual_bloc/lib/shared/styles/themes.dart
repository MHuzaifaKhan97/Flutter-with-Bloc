import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  // Appbar
  appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(color: Colors.black)),
  iconTheme: const IconThemeData(color: Colors.teal),
  primarySwatch: Colors.teal,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.teal),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 15.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xff333739),
  // Appbar
  appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff333739),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white)),
  iconTheme: const IconThemeData(color: Colors.teal),
  primarySwatch: Colors.teal,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.teal),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 15.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
