import 'package:flutter/material.dart';
import 'package:othman/OthmanApp.dart';
import 'package:othman/Services/QuranAPI.dart';

void main() async {
  WidgetsFlutterBinding();
  await QuranAPI.init();
  runApp(OthmanApp());
}


