import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/EpicDivider.dart';
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
          title: Container(
        width: double.infinity,
        child: Text(
          widget.character.name,
          textDirection: TextDirection.rtl,
        ),
      )),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          Text(widget.character.name),
          Text('ذكر في القران ؟ مرة'),
          EpicDivider(),
          Text(
            'نبذة عن الشخصية',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          Container(
            child: Text(
              widget.character.about,
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
              maxLines: charactersMaxLines,
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
            child: Center(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (charactersMaxLines == 3)
                      charactersMaxLines = 1000;
                    else
                      charactersMaxLines = 3;
                  });
                },
                icon: Icon(
                  charactersMaxLines == 3
                      ? Icons.arrow_drop_down_circle
                      : Icons.arrow_drop_up_sharp,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          EpicDivider(),
          FutureBuilder(
            future: QuranAPI.getAllVersesOfCharacter(widget.character.id),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<Verse> verses = snapshot.data;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                          future: QuranAPI.getSura(verses[index].suraNumber),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data.name}",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                        VerseWidget(
                          verse: verses[index],
                        ),
                      ],
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),
          EpicDivider(),
          Text('احداث مرتبطة بالشخصية'),
          FutureBuilder<List<Story>>(
            future: QuranAPI.getAllStoriesOfCharacter(widget.character.id),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isNotEmpty) {
                  List<Story> stories = snapshot.data;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                      return Text(stories[index].name);
                    },
                  );
                } else {
                  return Text("لايوجد");
                }
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
