import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/CharacterTile.dart';
import 'package:othman/components/LocationTile.dart';
import 'package:othman/models/Character.dart';
import 'package:othman/models/Sura.dart';
import 'package:quran/quran.dart';
import 'package:stopper/stopper.dart';

import '../../models/Location.dart';
import '../../models/Story.dart';
import '../../models/Verse.dart';

void showVerseDetails(BuildContext context, Verse verse) {
  PageController pg = new PageController();
  int pageSelected = 0;

  showStopper(
      context: context,
      stops: [
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.height,
      ],
      builder: (context, scrollController, scrollPhysics, stop) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStopperState) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Sura>(
                    future: QuranAPI.getSura(verse.suraNumber),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey[200],
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                snapshot.data.name,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(width: 12),
                                ],
                              ),
                            )
                          ],
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
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setStopperState(() {
                            pageSelected = 0;
                            pg.jumpToPage(0);
                          });
                        },
                        child: Icon(
                          Icons.chrome_reader_mode_sharp,
                          color: pageSelected == 0
                              ? Colors.white.withOpacity(1)
                              : Colors.white.withOpacity(0.45),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setStopperState(() {
                            pageSelected = 1;
                            pg.jumpToPage(1);
                          });
                        },
                        child: Icon(
                          Icons.person,
                          color: pageSelected == 1
                              ? Colors.white.withOpacity(1)
                              : Colors.white.withOpacity(0.45),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setStopperState(() {
                            pageSelected = 2;
                            pg.jumpToPage(2);
                          });
                        },
                        child: Icon(
                          Icons.location_on_rounded,
                          color: pageSelected == 2
                              ? Colors.white.withOpacity(1)
                              : Colors.white.withOpacity(0.45),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setStopperState(() {
                            pageSelected = 3;
                            pg.jumpToPage(3);
                          });
                        },
                        child: Icon(
                          Icons.event,
                          color: pageSelected == 3
                              ? Colors.white.withOpacity(1)
                              : Colors.white.withOpacity(0.45),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 25,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PageView(
                      controller: pg,
                      onPageChanged: (int page) {
                        setStopperState(() {
                          pageSelected = page;
                        });
                      },
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "تفسير الآية",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.chrome_reader_mode_sharp,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  verse.tafseer,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "شخصيات الآية",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder(
                                  future: QuranAPI.getAllCharactersOfVerse(
                                      verse.suraNumber, verse.verseNumber),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Character> characters =
                                          snapshot.data;
                                      if (characters.isNotEmpty)
                                        return Column(
                                          children:
                                              characters.map((Character char) {
                                            return CharacterTile(
                                                character: char);
                                          }).toList(),
                                        );
                                      else
                                        return Text(
                                          "لا يوجد",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "الأماكن المذكورة في الآية",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
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
                                            return LocationTile(c);
                                            // return Text("hi");
                                          }).toList(),
                                        );
                                      else
                                        return Text(
                                          "لا يوجد",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "الأحداث المذكورة في الآية",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.event,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
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
                                              fontSize: 20,
                                              color: Colors.white),
                                        );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}
