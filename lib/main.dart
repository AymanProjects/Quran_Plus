import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:othman/Screens/SurasScreen.dart';
import 'package:othman/Services/QuranAPI.dart';

void main() async {
  WidgetsFlutterBinding();
  await QuranAPI.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SurasScreen(),
      bottomNavigationBar: MoltenBottomNavigationBar(
        onTabChange: (index) {},
        selectedIndex: 0,
        tabs: [
          MoltenTab(icon: Icon(Icons.book)),
          MoltenTab(icon: Icon(Icons.book)),
          MoltenTab(icon: Icon(Icons.book)),
        ],
      ),
    );
  }
}
