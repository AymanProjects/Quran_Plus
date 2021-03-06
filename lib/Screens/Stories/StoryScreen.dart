import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/models/Story.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';

class StoryScreen extends StatefulWidget {
  final Story story;

  StoryScreen(this.story);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  int charactersMaxLines = 5;

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
          widget.story.name,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تفاصيل القصة',
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
                        widget.story.fullStory,
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
                          color: charactersMaxLines == 5
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Colors.transparent,
                          blurRadius: 20,
                          spreadRadius: 20,
                        )
                      ]),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (charactersMaxLines == 5)
                              charactersMaxLines = 1000;
                            else
                              charactersMaxLines = 5;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              charactersMaxLines == 5
                                  ? Icons.arrow_circle_down_rounded
                                  : Icons.arrow_circle_up_rounded,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 5),
                            charactersMaxLines == 5
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      "اقرأ المزيد",
                                      style: TextStyle(
                                          fontSize: 19,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'آيات ذكرت بها القصة',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    FutureBuilder(
                      future: QuranAPI.getAllVersesOfStory(widget.story.id),
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
                                    future: QuranAPI.getSura(
                                        verses[index].suraNumber),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          "${snapshot.data.name}",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                  ],
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
