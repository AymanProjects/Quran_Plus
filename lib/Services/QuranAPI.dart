import 'dart:io';

import 'package:flutter/services.dart';
import 'package:othman/models/Character.dart';
import 'package:othman/models/Location.dart';
import 'package:othman/models/Story.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';
import 'package:sqflite/sqflite.dart';

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
      db = await openDatabase(path, readOnly: true, onOpen: (db) async {
        //   print(await db.rawQuery("PRAGMA table_info(suras);"));
      });
    } catch (e) {
      print(e.toString());
    }

    //  print((await getCharactersOfSura(2)).toString());

    // print((await getAllVersesOfSura(2))[200].verse.toString());
  }

  static Future<List<Sura>> getAllSuras() async {
    List<Map> rawSuras = await db.rawQuery('select * from suras;');
    List<Sura> suras = [];
    for (int i = 0; i < rawSuras.length; i++) {
      suras.add(Sura.fromJson(rawSuras[i]));
    }
    return suras;
  }

  static Future<List<Character>> getCharactersOfSura(int suraNumber) async {
    String query =
        'select * from characters,verseCharacter,verses where verseCharacter.suraNumber=$suraNumber AND verseCharacter.verseNumber in (select verseNumber from verses where suraNumber=$suraNumber)';

    // 'select * from characters,verseCharacters,verses where characterID in (select characterID from verseCharacter where suraNumber=$suraNumber;)';
    List<Map> json = await db.rawQuery(query);
    List<Character> characters = [];
    for (int i = 0; i < json.length; i++) {
      characters.add(Character.fromJson(json[i]));
    }

    return characters;
  }

  static Future<List<Location>> getLocationsOfSura(int suraNumber) async {
    String query =
        'select * from locations where ID in (select locationID from verses where suraNumber=$suraNumber);';
    // 'select * from characters,verseCharacters,verses where characterID in (select characterID from verseCharacter where suraNumber=$suraNumber;)';
    List<Map> json = await db.rawQuery(query);
    List<Location> locations = [];
    for (int i = 0; i < json.length; i++) {
      locations.add(Location.fromJson(json[i]));
    }

    return locations;
  }

  static Future<List<Story>> getStoriesOfSura(int suraNumber) async {
    String query =
        'select * from stories where ID in (select storyID from verses where suraNumber=$suraNumber);';
    // 'select * from characters,verseCharacters,verses where characterID in (select characterID from verseCharacter where suraNumber=$suraNumber;)';
    List<Map> json = await db.rawQuery(query);
    List<Story> stories = [];
    for (int i = 0; i < json.length; i++) {
      stories.add(Story.fromJson(json[i]));
    }

    return stories;
  }

  static Future<List<Verse>> getAllVersesOfSura(int suraNumber) async {
    List<Map> rawVerses =
        await db.rawQuery('select * from verses where suraNumber=$suraNumber;');
    List<Verse> verses = [];
    for (int i = 0; i < rawVerses.length; i++) {
      verses.add(Verse.fromJson(rawVerses[i]));
    }
    return verses;
  }

  static Future<List<Character>> getCharactersOfVerse(
      int suraNumber, int verseNumber) async {
    String query =
        'select * from characters,verseCharacter where verseCharacter.verseNumber=$verseNumber AND verseCharacter.suraNumber=$suraNumber AND verseCharacter.characterID=characters.ID';
    // String query = "select * from characters";

    List<Map> json = await db.rawQuery(query);

    List<Character> characters = [];
    for (int i = 0; i < json.length; i++) {
      characters.add(Character.fromJson(json[i]));
    }

    return characters;
  }

  static Future<List<Location>> getLocationOfVerse(
      int suraNumber, int verseNumber) async {
    String query =
        'select * from locations,verses where locations.ID=verses.locationID AND verseNumber=$verseNumber AND suraNumber=$suraNumber;';
    // String query = 'select * from locations';
    List<Map> json = await db.rawQuery(query);
    List<Location> locations = [];
    for (int i = 0; i < json.length; i++) {
      locations.add(Location.fromJson(json[i]));
    }

    return locations;
  }

  static Future<List<Story>> getStoryOfVerse(
      int suraNumber, int verseNumber) async {
    String query =
        'select * from stories,verses where stories.ID=verses.storyID AND verseNumber=$verseNumber AND suraNumber=$suraNumber;';
    // 'select * from characters,verseCharacters,verses where characterID in (select characterID from verseCharacter where suraNumber=$suraNumber;)';
    List<Map> json = await db.rawQuery(query);
    List<Story> stories = [];
    for (int i = 0; i < json.length; i++) {
      stories.add(Story.fromJson(json[i]));
    }

    return stories;
  }
}
