import 'package:flutter/material.dart';

TextStyle textStyle(double size, [Color? color, FontWeight? weight]) {
  return TextStyle(
    color: color ?? Colors.white,
    fontSize: size,
    fontWeight: weight ?? FontWeight.normal,
    decoration: TextDecoration.none,
  );
}
