import 'package:flutter/material.dart';
import 'package:flutter_crud/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData MyTheme = ThemeData(
  primaryColor: myColor,
  primarySwatch: myColor,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: textFormFieldColor,
    contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: BorderSide(
        color: fabColor,
        width: 4
      ),
    ),
  ),
  textTheme: GoogleFonts.nunitoTextTheme()
);
