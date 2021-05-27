import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/CharacterTile.dart';
import 'package:othman/models/Character.dart';
import 'package:othman/models/Sura.dart';
import 'package:quran/quran.dart';
import 'package:stopper/stopper.dart';

import '../../models/Location.dart';
import '../../models/Story.dart';
import '../../models/Verse.dart';

void showVerseDetails(BuildContext context, Verse verse) {
  showStopper(
      context: context,
      stops: [
        MediaQuery.of(context).size.height * 0.75,
        MediaQuery.of(context).size.height * 0.75,
      ],
      builder: (context, scrollController, scrollPhysics, stop) {
        return Container(
          color: Colors.indigoAccent.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: ListView(
                physics: scrollPhysics,
                controller: scrollController,
                children: [
                  FutureBuilder<Sura>(
                    future: QuranAPI.getSura(verse.suraNumber),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "${snapshot.data.name}",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  Text(
                    "آية رقم " + (getVerseEndSymbol(verse.verseNumber)),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    "تفسير الآية",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    verse.tafseer,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "شخصيات الآية",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      FutureBuilder(
                        future: QuranAPI.getAllCharactersOfVerse(
                            verse.suraNumber, verse.verseNumber),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            List<Character> characters = snapshot.data;
                            if (characters.isNotEmpty)
                              return Column(
                                children: characters.map((Character char) {
                                  return CharacterTile(character: char);
                                }).toList(),
                              );
                            else
                              return Text(
                                "لا يوجد",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        "اماكن ذكرت في الآية",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      FutureBuilder(
                        future: QuranAPI.getLocationOfVerse(
                            verse.suraNumber, verse.verseNumber),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            List<Location> locations = snapshot.data;
                            if (locations.isNotEmpty)
                              return Column(
                                children: locations.map((Location c) {
                                  return Text(c.name);
                                }).toList(),
                              );
                            else
                              return Text(
                                "لا يوجد",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        "قصة الآية",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      FutureBuilder(
                        future: QuranAPI.getStoryOfVerse(
                            verse.suraNumber, verse.verseNumber),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            List<Story> story = snapshot.data;
                            if (story.isNotEmpty)
                              return Column(
                                children: story.map((Story s) {
                                  return Text(s.name);
                                }).toList(),
                              );
                            else
                              return Text(
                                "لا يوجد",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                ]),
          ),
        );
      });
}
