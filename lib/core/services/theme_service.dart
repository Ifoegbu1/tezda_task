import 'package:flutter/material.dart';
import 'package:tezda_task/core/services/helpers/theme_config.dart';
import 'package:tezda_task/core/services/storage_service.dart';

class ThemeService {
  ThemeService._();

  static ThemeService? _instance;

  static Future<ThemeService> get instance async {
    if (_instance == null) {
      await StorageService.instance;

      _instance = ThemeService._();
    }
    return _instance!;
  }

  final allThemes = <String, ThemeData>{
    'dark': appDarkTheme,
    'light': appLightTheme,
  };

  get initial {
    String? themeName = StorageService.prefs.getString('theme');
    themeName ??= 'light';
    return allThemes[themeName];
  }

  save(String newThemeName) {
    var currentThemeName = StorageService.prefs.getString('theme');
    if (currentThemeName != null) {
      StorageService.prefs.setString('previousThemeName', currentThemeName);
    }
    StorageService.prefs.setString('theme', newThemeName);
  }

  ThemeData getByName(String name) {
    return allThemes[name]!;
  }
}

final allThemes = <String, ThemeData>{
  'dark': appDarkTheme,
  'light': appLightTheme,
};
ThemeData defaultTheme() {
  String? themeName = StorageService.prefs.getString('theme');
  themeName ??= 'light';
  return allThemes[themeName]!;
}
