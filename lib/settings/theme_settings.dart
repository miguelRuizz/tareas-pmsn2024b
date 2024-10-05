import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme(){
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 246, 213),
      primaryColor: const Color.fromARGB(255, 230, 203, 109),
      listTileTheme: ListTileThemeData(textColor: Colors.black),
      appBarTheme: AppBarTheme(color: Color.fromARGB(255, 255, 246, 213)),
      dividerTheme: DividerThemeData(color: Colors.black),
    ); // CopyWith copia el objeto para hacerlo mutable
  }

  static ThemeData darkTheme(){
    final theme = ThemeData.dark();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 105, 87, 87),
      primaryColor: Colors.black,
      listTileTheme: ListTileThemeData(textColor: Colors.white),
      dividerTheme: DividerThemeData(color: Colors.white)
    ); // CopyWith copia el objeto para hacerlo mutable
  }

  static ThemeData warmTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color.fromARGB(215, 121, 203, 153),
      )
    );
  }

  // Tema personalizable basado en los valores que el usuario selecciona
  static ThemeData customTheme({
    required Color primaryColor,
    required Color scaffoldBackgroundColor,
    required Color textColor,
    required String fontFamily,
  }) {
    final theme = ThemeData.light();
    return theme.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(color: scaffoldBackgroundColor),
      textTheme: theme.textTheme.apply(
        bodyColor: textColor,
        fontFamily: fontFamily,
      ),
    );
  }
}