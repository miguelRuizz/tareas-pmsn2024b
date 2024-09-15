import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme(){
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: Colors.amber
    ); // CopyWith copia el objeto para hacerlo mutable
  }

  static ThemeData darkTheme(){
    final theme = ThemeData.dark();
    return theme.copyWith(
      scaffoldBackgroundColor: Colors.grey
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