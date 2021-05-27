import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/EpicDivider.dart';
import 'package:othman/models/Character.dart';
import 'package:othman/models/Story.dart';
import 'package:othman/models/Verse.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;
  CharacterScreen({this.character});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        child: Text(
          character.name,
          textDirection: TextDirection.rtl,
        ),
      )),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          Text(character.name),
          Text('ذكر في القران ؟ مرة'),
          EpicDivider(),
          Text(character.about),
          EpicDivider(),
          FutureBuilder(
            future: QuranAPI.getAllVersesOfCharacter(character.id),
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
                    return VerseWidget(verse: verses[index]);
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),
          EpicDivider(),
          Text('احداث مرتبطة بالشخصية'),
          FutureBuilder<List<Story>>(
            future: QuranAPI.getAllStoriesOfCharacter(character.id),
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
