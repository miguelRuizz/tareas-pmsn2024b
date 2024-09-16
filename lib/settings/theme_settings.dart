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
}