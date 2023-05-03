import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/form_screen.dart';
import 'package:flutter_crud/screens/home.dart';
import 'package:flutter_crud/themes/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme,
      initialRoute: "home",
      routes: {
        "home": (context) => const Home(),
        "form": (context) => FormScreen(),
      },
    );
  }
}