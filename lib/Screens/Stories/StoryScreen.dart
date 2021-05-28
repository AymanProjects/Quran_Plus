import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/EpicDivider.dart';
import 'package:othman/models/Story.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';

class StoryScreen extends StatelessWidget {
  final Story story;
  StoryScreen(this.story);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        child: Text(
          story.name,
          textDirection: TextDirection.rtl,
        ),
      )),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          Text(story.name),
          Text('تفاصيل الحدث'),
          Text(story.fullStory),
          EpicDivider(),
          Text('الآيات المتعلقة بالحدث'),
          FutureBuilder(
            future: QuranAPI.getAllVersesOfStory(story.id),
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
        ],
      ),
    );
  }
}
