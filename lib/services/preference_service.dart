import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  // static const _primaryColor = '';
  // static const _scaffoldBackgroundColor = '';
  // static const _fontFamily = '';

  // // Guardar el color primario
  // Future<void> _savePrimaryColor(Color color) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_primaryColor, color.value);
  // }

  // // Guardar el color primario
  // Future<void> _saveScaffoldBgColor(Color color) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_scaffoldBackgroundColor, color.value);
  // }

  // // Guardar la fuente de texto
  // Future<void> _saveSelectedFont(String font) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_fontFamily, font);
  // }

  // Future<Color> _getPrimaryColor() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? colorValue = prefs.getInt(_primaryColor);
  //    //?? Colors.blue.value; // Valor por defecto
  //  //return Color(colorValue);
  //   if (colorValue != null) {
  //     GlobalValues.customPrimaryColor.value = Color(colorValue);
  //   } else {
  //     colorValue = Colors.blue.value;
  //   }
  //   return Color(colorValue);
  // }

  // Guardar si está en tema oscuro
  Future<void> saveIfDarkTheme(bool isDarkTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);
    print("Tema oscuro guardado: $isDarkTheme");
  }

  // Obtener si está en tema oscuro
  Future<bool> getIfDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? luna = prefs.getBool('isDarkTheme');
    print("Tema oscuro flag devuelta: $luna");
    return prefs.getBool('isDarkTheme') ?? false; // Por defecto tema claro
  }

  // Guardar si está en tema personalizado
  Future<void> saveIfCustomTheme(bool isCustomTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCustomTheme', isCustomTheme);
    print("Tema personalizado guardado: $isCustomTheme");
  }

  // Obtener si está en tema personalizado
  Future<bool> getIfCustomTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Tema personalizado devuelto");
    return prefs.getBool('isCustomTheme') ?? false; // Por defecto no es el custom
  }

  Future<void> saveThemeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Guardar el color primario
    prefs.setInt('customPrimaryColor', GlobalValues.customPrimaryColor.value.value);
    // Guardar el color de fondo
    prefs.setInt('customScaffoldBackgroundColor', GlobalValues.customScaffoldBackgroundColor.value.value);
    // Guardar la fuente
    if (GlobalValues.customFontFamily.value != null) {
      prefs.setString('customFontFamily', GlobalValues.customFontFamily.value!);
    } else {
      prefs.remove('customFontFamily');
    }
  }

  Future<void> loadThemeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Recuperar el color primario
    int? primaryColorValue = prefs.getInt('customPrimaryColor');
    if (primaryColorValue != null) {
      GlobalValues.customPrimaryColor.value = Color(primaryColorValue);
    }
    // Recuperar el color de fondo
    int? bgColorValue = prefs.getInt('customScaffoldBackgroundColor');
    if (bgColorValue != null) {
      GlobalValues.customScaffoldBackgroundColor.value = Color(bgColorValue);
    }
    // Recuperar la fuente
    String? fontFamily = prefs.getString('customFontFamily');
    GlobalValues.customFontFamily.value = fontFamily;
  }
}