import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';
const MaterialColor ThemeColor = MaterialColor(
  0xFFe7e7e7,
  <int, Color>{
    50: Colors.deepPurple,
    100: Colors.deepPurple,
    200: Colors.deepPurple,
    300: Colors.deepPurple,
    400: Colors.deepPurple,
    500: Colors.deepPurple,
    600: Colors.deepPurple,
    700: Colors.deepPurple,
    800: Colors.deepPurple,
    900: Colors.deepPurple,
  },
);


ThemeData lightTheme = ThemeData(

  bottomAppBarColor: mainColor,
  primaryColor: mainColor,
  indicatorColor: mainColor,
 // primarySwatch: ThemeColor,
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    //titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
    fontFamily: "Jannah",
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline1: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline3: TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.white,

  ),
  fontFamily: "Jannah",
);
ThemeData darkTheme = ThemeData(
   cardTheme: CardTheme(
     color: HexColor('333739'),
   ),
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: HexColor('333739'),
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
      fontFamily: "Jannah",
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    headline5: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: "Jannah",
  bottomAppBarTheme: BottomAppBarTheme(
    color: HexColor('333739'),

  ),
);