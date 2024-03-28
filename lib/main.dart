import 'package:flutter/material.dart';
import 'package:game_calendar/const/colors.dart';
import 'package:game_calendar/screens/home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
    ),
    home: const HomeScreen(),
  ));
}
