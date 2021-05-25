import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Othman',
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
      appBar: AppBar(title: Text('Othman App')),
      body: Container(
        color: Colors.black87,
      ),
      bottomNavigationBar: MoltenBottomNavigationBar(
        onTabChange: (index) {},
        selectedIndex: 0,
        tabs: [
          MoltenTab(icon: Icon(Icons.add_alarm)),
          MoltenTab(icon: Icon(Icons.access_alarms)),
          MoltenTab(icon: Icon(Icons.delete_sweep)),
          MoltenTab(icon: Icon(Icons.wine_bar)),
        ],
      ),
    );
  }
}
