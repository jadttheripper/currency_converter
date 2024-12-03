import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
    ),
    textTheme: TextTheme(
  titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Instead of headline6
  bodyLarge: TextStyle(color: Colors.black), // Instead of bodyText1
  bodyMedium: TextStyle(color: Colors.grey), // Optional for more text variations
  )
  ,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
    ),
     textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Instead of headline6
        bodyLarge: TextStyle(color: Colors.black), // Instead of bodyText1
        bodyMedium: TextStyle(color: Colors.grey), // Optional for more text variations
      )

  );
}
// dark / light mode switcher
