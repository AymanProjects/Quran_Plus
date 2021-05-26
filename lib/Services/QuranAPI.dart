import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class QuranAPI {
  static Database db;

  static init() async {
    try {
      var databasesPath = await getDatabasesPath();
      var path = '$databasesPath/quran.db';
      // delete existing if any
      await deleteDatabase(path);
      // Copy from asset
      ByteData data = await rootBundle.load("assets/OthmanApp.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes, flush: true);
      // open the database
      db = await openDatabase(
        path,
        readOnly: true,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  List<Ver> getVersesOfSura(int suraNumber){

  }

}
