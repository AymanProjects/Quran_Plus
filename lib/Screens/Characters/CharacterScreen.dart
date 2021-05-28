import 'package:flutter/material.dart';
import 'package:othman/Screens/Stories/StoryScreen.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/EpicTile.dart';
import 'package:othman/models/Character.dart';
import 'package:othman/models/Story.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';

class CharacterScreen extends StatefulWidget {
  final Character character;
  CharacterScreen({this.character});

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  int charactersMaxLines = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Theme.of(context).primaryColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.character.name,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'نبذة',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  child: Text(
                    widget.character.about,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: charactersMaxLines,
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: charactersMaxLines == 3
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Colors.transparent,
                      blurRadius: 20,
                      spreadRadius: 20,
                    )
                  ]),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (charactersMaxLines == 3)
                          charactersMaxLines = 1000;
                        else
                          charactersMaxLines = 3;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          charactersMaxLines == 3
                              ? Icons.arrow_circle_down_rounded
                              : Icons.arrow_circle_up_rounded,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 5),
                        charactersMaxLines == 3
                            ? Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  "اقرأ المزيد",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Text(
                  'آيات ذكرت بها الشخصية',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "( ذكرت في القرآن ${widget.character.numOfOccurances.toString()} مرة )",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FutureBuilder(
                  future: QuranAPI.getAllVersesOfCharacter(widget.character.id),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      List<Verse> verses = snapshot.data;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 25,
                            thickness: 1,
                            endIndent: 40,
                            indent: 40,
                          );
                        },
                        itemCount: verses.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder<Sura>(
                                future:
                                    QuranAPI.getSura(verses[index].suraNumber),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      "${snapshot.data.name}",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                      ),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              VerseWidget(
                                verse: verses[index],
                                fontSize: 18,
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                Divider(
                  thickness: 1,
                  height: 25,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'قصص متعلقة بالشخصية',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                FutureBuilder<List<Story>>(
                  future:
                      QuranAPI.getAllStoriesOfCharacter(widget.character.id),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isNotEmpty) {
                        List<Story> stories = snapshot.data;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 25,
                              thickness: 1,
                              endIndent: 40,
                              indent: 40,
                            );
                          },
                          itemCount: stories.length,
                          itemBuilder: (context, index) {
                            return EpicTile(
                              Icons.bookmark,
                              title: stories[index].name,
                              onClick: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return StoryScreen(stories[index]);
                                  },
                                ));
                              },
                            );
                          },
                        );
                      } else {
                        return Text(
                          'لا يوجد',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      }
                    }
                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
