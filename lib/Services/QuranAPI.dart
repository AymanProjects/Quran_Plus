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
  }

  static Future<List<Sura>> getAllSuras() async {
    List<Map> json = await db.rawQuery('select * from suras;');
    List<Sura> suras = [];
    for (int i = 0; i < json.length; i++) {
      suras.add(Sura.fromJson(json[i]));
    }
    return suras;
  }

  static Future<List<Character>> getAllCharacters() async {
    List<Map> json = await db.rawQuery('select * from characters;');
    List<Character> characters = [];
    for (int i = 0; i < json.length; i++) {
      characters.add(Character.fromJson(json[i]));
    }
    return characters;
  }

  static Future<List<Story>> getAllStories() async {
    List<Map> json = await db.rawQuery('select * from stories;');
    List<Story> stories = [];
    for (int i = 0; i < json.length; i++) {
      stories.add(Story.fromJson(json[i]));
    }
    return stories;
  }

  static Future<Sura> getSura(int suraNumber) async {
    List<Map> json =
        await db.rawQuery('select * from suras where number=$suraNumber;');
    return Sura.fromJson(json.first);
  }

  static Future<List<Character>> getAllCharactersOfSura(int suraNumber) async {
    // String query =
    //     'select * from characters,verseCharacter,verses where verseCharacter.suraNumber=$suraNumber AND verseCharacter.verseNumber in (select verseNumber from verses where suraNumber=$suraNumber)';
    String query =
        "select * from characters where characters.ID in (select characterID from verseCharacter where suraNumber=$suraNumber);";
    List<Map> json = await db.rawQuery(query);
    List<Character> characters = [];
    for (int i = 0; i < json.length; i++) {
      characters.add(Character.fromJson(json[i]));
    }
    return characters;
  }

  static Future<List<Location>> getAllLocationsOfSura(int suraNumber) async {
    String query =
        'select * from locations where ID in (select locationID from verseLocations where suraNumber=$suraNumber);';
    // 'select * from locations,verses where ID in (select locationID from verses where suraNumber=$suraNumber);';
    // String query = 'select * from locations;';

    List<Map> json = await db.rawQuery(query);
    List<Location> locations = [];
    //  print(json);
    for (int i = 0; i < json.length; i++) {
      locations.add(Location.fromJson(json[i]));
    }
    return locations;
  }

  static Future<List<Story>> getAllStoriesOfSura(int suraNumber) async {
    String query =
        'select * from stories where ID in (select storyID from verses where suraNumber=$suraNumber);';
    List<Map> json = await db.rawQuery(query);
    List<Story> stories = [];
    for (int i = 0; i < json.length; i++) {
      stories.add(Story.fromJson(json[i]));
    }
    return stories;
  }

  static Future<List<Story>> getAllStoriesOfCharacter(int characterID) async {
    String query =
        'select * from stories where ID in (select storyID from verses,verseCharacter where verseCharacter.characterID=$characterID AND verseCharacter.verseNumber=verses.verseNumber AND verseCharacter.suraNumber=verses.suraNumber);';
    List<Map> json = await db.rawQuery(query);
    List<Story> stories = [];
    for (int i = 0; i < json.length; i++) {
      stories.add(Story.fromJson(json[i]));
    }
    return stories;
  }

  static Future<List<Verse>> getAllVersesOfCharacter(int characterID) async {
    String query =
        'select * from verses,verseCharacter where verseCharacter.verseNumber=verses.verseNumber AND verseCharacter.suraNumber=verses.suraNumber AND verseCharacter.characterID=$characterID';
    List<Map> json = await db.rawQuery(query);
    List<Verse> verses = [];
    for (int i = 0; i < json.length; i++) {
      verses.add(Verse.fromJson(json[i]));
    }
    return verses;
  }

  static Future<List<Character>> getAllCharactersOfVerse(
      int suraNumber, int verseNumber) async {
    String query =
        'select * from characters,verseCharacter where verseCharacter.verseNumber=$verseNumber AND verseCharacter.suraNumber=$suraNumber AND verseCharacter.characterID=characters.ID';
    List<Map> json = await db.rawQuery(query);
    List<Character> characters = [];
    for (int i = 0; i < json.length; i++) {
      characters.add(Character.fromJson(json[i]));
    }
    return characters;
  }

  static Future<List<Verse>> getAllVersesOfSura(int suraNumber) async {
    List<Map> json =
        await db.rawQuery('select * from verses where suraNumber=$suraNumber;');
    List<Verse> verses = [];
    for (int i = 0; i < json.length; i++) {
      verses.add(Verse.fromJson(json[i]));
    }
    return verses;
  }

  static Future<List<Location>> getLocationOfVerse(
      int suraNumber, int verseNumber) async {
    // String query =
    //     'select * from verses where verseNumber=$verseNumber AND suraNumber=$suraNumber;';
    // String query =
    //     "select * from locations where ID in (select locationID from verses where verseNumber=$verseNumber AND suraNumber=$suraNumber);";
    String query =
        "select * from locations where ID in (select locationID from verseLocations where verseNumber=$verseNumber AND suraNumber=$suraNumber);";
    List<Map> json = await db.rawQuery(query);
    //  print(json);
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
    List<Map> json = await db.rawQuery(query);
    List<Story> stories = [];
    for (int i = 0; i < json.length; i++) {
      stories.add(Story.fromJson(json[i]));
    }
    return stories;
  }

  static Future<List<Location>> getAllLocations() async {
    List<Map> json = await db.rawQuery('select * from locations;');
    List<Location> locations = [];
    for (int i = 0; i < json.length; i++) {
      locations.add(Location.fromJson(json[i]));
    }
    return locations;
  }

  static Future<List<Verse>> getAllVersesOfLocation(int locationID) async {
    String query =
        'select * from verses,verseLocations where verseLocations.verseNumber=verses.verseNumber AND verseLocations.suraNumber=verses.suraNumber AND verseLocations.locationID=$locationID';
    List<Map> json = await db.rawQuery(query);
    List<Verse> verses = [];
    for (int i = 0; i < json.length; i++) {
      verses.add(Verse.fromJson(json[i]));
    }
    return verses;
  }

  static Future<List<Verse>> getAllVersesOfStory(int storyID) async {
    String query =
        'select * from verses where storyID=$storyID';
    List<Map> json = await db.rawQuery(query);
    List<Verse> verses = [];
    for (int i = 0; i < json.length; i++) {
      verses.add(Verse.fromJson(json[i]));
    }
    return verses;
  }
}
