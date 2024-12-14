import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.black))),
      cardTheme: const CardTheme(color: Colors.white),
      buttonTheme: const ButtonThemeData(buttonColor: (Colors.white)));

  //*/*/*/*/*/*/*/*/*/*//////////////////////////////////////////////////

  static final darkTheme = ThemeData(
      //primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
       textTheme: const TextTheme(
         bodyLarge: TextStyle(color: Colors.white),
         bodyMedium: TextStyle(color: Colors.white),).apply(
         bodyColor: Colors.white,
         displayColor: Colors.white,
       ),
      //   headlineLarge: TextStyle(color: Colors.white),
      //   headlineMedium: TextStyle(color: Colors.white),
      //   headlineSmall: TextStyle(color: Colors.white),
      //   labelLarge: TextStyle(color: Colors.white),
      //   labelMedium: TextStyle(color: Colors.white),
      //   labelSmall: TextStyle(color: Colors.white),
      //   titleLarge: TextStyle(color: Colors.white),
      //   titleMedium: TextStyle(color: Colors.white),
      //   titleSmall: TextStyle(color: Colors.white),
      //   displayMedium: TextStyle(color: Colors.white),
      //   displayLarge: TextStyle(color: Colors.white),
      //   displaySmall: TextStyle(color: Colors.white),
      //   bodySmall: TextStyle(color: Colors.white),
      //   bodyLarge: TextStyle(color: Colors.white),
      //   bodyMedium: TextStyle(color: Colors.white),
       //),
      iconTheme: const IconThemeData(color: Colors.white),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white))),
      cardTheme: const CardTheme(color: Colors.black),
      buttonTheme: const ButtonThemeData(buttonColor: (Colors.white)));
}
