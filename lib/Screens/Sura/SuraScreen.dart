import 'package:flutter/material.dart';
import 'package:othman/Screens/Sura/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';

class SuraScreen extends StatelessWidget {
  final Sura sura;
  SuraScreen({this.sura});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        child: Text(
          sura.name,
          textDirection: TextDirection.rtl,
        ),
      )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: QuranAPI.getAllVersesOfSura(sura.number),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<Verse> verses = snapshot.data;
              return Column(
                children: verses.map((verse) {
                  return VerseWidget(verse: verse);
                }).toList(),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
