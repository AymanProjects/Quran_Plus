import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/CharacterTile.dart';
import 'package:othman/components/LocationTile.dart';
import 'package:othman/models/Character.dart';
import 'package:othman/models/Location.dart';
import 'package:othman/models/Story.dart';
import 'package:othman/models/Sura.dart';
import 'package:stopper/stopper.dart';

void showSuraDetails(BuildContext context, Sura sura) {
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
                  future: QuranAPI.getSura(sura.number),
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
                Divider(
                  thickness: 1,
                ),
                Text(
                  "رقم السورة",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  sura.number.toString(),
                  textDirection: TextDirection.rtl,
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
                  "نوع السورة",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  sura.type ?? 'غير معروف',
                  textDirection: TextDirection.rtl,
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
                  "عدد آيات السورة",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  sura.numberOfVerses.toString(),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "الشخصيات المذكورة في السورة",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    FutureBuilder(
                      future: QuranAPI.getAllCharactersOfSura(sura.number),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Text(
                      "اماكن ذكرت في السورة",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    FutureBuilder(
                      future: QuranAPI.getAllLocationsOfSura(sura.number),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          List<Location> locations = snapshot.data;
                          if (locations.isNotEmpty)
                            return Column(
                              children: locations.map((Location c) {
                                return LocationTile(c);
                              }).toList(),
                            );
                          else
                            return Text(
                              "لا يوجد",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Text(
                      "قصص ذكرت في السورة",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    FutureBuilder(
                      future: QuranAPI.getAllStoriesOfSura(sura.number),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
