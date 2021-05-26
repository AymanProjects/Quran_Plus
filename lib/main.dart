import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding();

  try {
    var databasesPath = await getDatabasesPath();
    var path = '$databasesPath/test.db';
    // delete existing if any
    await deleteDatabase(path);
    // Make sure the parent directory exists

    // Copy from asset
    ByteData data = await rootBundle.load("assets/OthmanApp.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    // open the database
    var db = await openDatabase(
      path,
      readOnly: true,
      onOpen: (db) async {
        print(await db.rawQuery(
            'SELECT verse FROM verses where verseNumber=1 AND suraNumber=2'));
      },
    );
  } catch (e) {
    print(e.toString());
  }
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
