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
  double width;

  double height;

  int charactersMaxLines = 5;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          widget.story.name,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
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
              ),
              Divider(
                thickness: 1,
                height: 25,
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: height * 0.8,
                child: SingleChildScrollView(
                  child: Column(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (charactersMaxLines == 5)
                                    charactersMaxLines = 1000;
                                  else
                                    charactersMaxLines = 5;
                                });
                              },
                              icon: Icon(
                                charactersMaxLines == 5
                                    ? Icons.arrow_circle_down_rounded
                                    : Icons.arrow_circle_up_rounded,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
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
                      Divider(
                        thickness: 1,
                        height: 25,
                      ),
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
