import 'package:flutter/material.dart';

class AppStyle {
  // Bold text with customizable size and color
  static TextStyle boldText({double size = 24, Color color = Colors.black}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: color,
    );
  }

  // Light text with customizable size and color
  static TextStyle lightText({double size = 17, Color color = Colors.grey}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: size,
      color: color,
    );
  }

  // Bold text for price with customizable size
  static TextStyle boldTextPrice({double size = 24}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: Colors.red,
    );
  }
}
