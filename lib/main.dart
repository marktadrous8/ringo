import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ringo/screens/home_screen.dart';
import 'package:ringo/screens/login_screen.dart';
import 'package:ringo/screens/project_summary_screen.dart';
import 'package:ringo/utils/colors.dart';
import 'package:ringo/utils/custom_text_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Urbanist'),
          bodyMedium: TextStyle(fontFamily: 'Urbanist'),
        ),
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
