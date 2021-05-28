import 'package:flutter/material.dart';
import 'package:othman/OthmanApp.dart';
import 'package:othman/Services/QuranAPI.dart';

void main() async {
  WidgetsFlutterBinding();
  await QuranAPI.init();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.purple,
      primaryColor: Color(0xff9E73D7),
      primaryColorDark: Color(0xff734DA4),
      fontFamily: 'Tajawal',
    ),
    debugShowCheckedModeBanner: false,
    home: OthmanApp(),
  ));
}
