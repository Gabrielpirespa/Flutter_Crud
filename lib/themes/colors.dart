import 'package:flutter/material.dart';

const MaterialColor myColor = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFF1F7FD),
  100: Color(0xFFDBECFA),
  200: Color(0xFFC4DFF7),
  300: Color(0xFFACD2F3),
  400: Color(0xFF9AC8F1),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF80B8EC),
  700: Color(0xFF75AFE9),
  800: Color(0xFF6BA7E7),
  900: Color(0xFF5899E2),
});
const int _primaryPrimaryValue = 0xFF88BEEE;

const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFE0EEFF),
  700: Color(0xFFC7E1FF),
});
const int _primaryAccentValue = 0xFFFFFFFF;


const Color fabColor = Color.fromRGBO(77, 141, 185, 1.0);
const Color backgroundColor = Color.fromRGBO(152, 187, 218, 1.0);
const Color textFormFieldColor = Color.fromRGBO(224, 225, 231, 1.0);
