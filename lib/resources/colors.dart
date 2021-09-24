import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const int _primary = 0xFF3B5CCB;
  static const Color primary = Color(_primary);

  static const MaterialColor blue = MaterialColor(
    _primary,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_primary),
      600: Color(0xFF1E78E5),
      700: Color(0xFF1957D2),
      800: Color(0xFF153AC0),
      900: Color(0xFF0C2379),
    },
  );
}
