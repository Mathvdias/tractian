import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      primaryColor: const Color.fromRGBO(23, 25, 45, 1.0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(23, 25, 45, 1.0),
      ),
    );
  }
}
