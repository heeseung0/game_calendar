import 'package:flutter/material.dart';

TextStyle textStyle(double size, [Color? color]) {
  return TextStyle(
    color: color ?? Colors.white,
    fontSize: size,
    fontWeight: FontWeight.w900,
  );
}
