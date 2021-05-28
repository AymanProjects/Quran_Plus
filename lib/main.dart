import 'package:flutter/material.dart';
import 'package:othman/OthmanApp.dart';
import 'package:othman/Services/QuranAPI.dart';

void main() async {
  WidgetsFlutterBinding();
  await QuranAPI.init();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
      primaryColor: Color(0xff78B499),
      primaryColorDark: Color(0xff669b81),
      fontFamily: 'Tajawal',
    ),
    debugShowCheckedModeBanner: false,
    home: OthmanApp(),
  ));
}
