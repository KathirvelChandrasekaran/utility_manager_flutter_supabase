import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: const Color(0XFF050406),
  primaryColor: const Color(0XFFAD6C98),
  accentColor: Color(0XFFF0DDF8),
  hintColor: Color(0XFF7293C1),
  dividerColor: Color(0XFFBAAAB9),
  errorColor: Color(0XFFCE1212),
  appBarTheme: AppBarTheme(
    color: Color(0XFF050406),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Color(
        0XFFAD6C98,
      ),
    ),
    brightness: Brightness.light,
  ),
  indicatorColor: Color(0XFFAD6C98),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0XFFAD6C98),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Color(0XFFAD6C98),
    ),
  ),
);
