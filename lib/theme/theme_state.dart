import 'package:flutter/material.dart';

import 'app_theme.dart';

abstract class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(AppThemes.lightTheme);
}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(AppThemes.darkTheme);
}
