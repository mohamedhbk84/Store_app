import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
ThemeData lightmode =ThemeData(
  primaryColor: Colors.white,
  colorScheme: ColorScheme.light(),
  iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),

  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:const AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme:const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme:const TextTheme(
      headline1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.black),
      headline2: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic,color: Colors.black),
      headline3: TextStyle(fontSize: 18.0,color: Colors.black),

    bodyText1: TextStyle(

      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);

ThemeData darkMode =ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.grey.shade900,
  primaryColor: Colors.black,
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold , color: Colors.white),
    headline2: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic,color: Colors.white),
    headline3: TextStyle(fontSize: 18.0,color: Colors.white),
    bodyText1: TextStyle(

      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.dark(),
  iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
 // scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  // textTheme: TextTheme(
  //   bodyText1: TextStyle(
  //     fontSize: 18.0,
  //     fontWeight: FontWeight.w600,
  //     color: Colors.white,
  //   ),
  // ),
);