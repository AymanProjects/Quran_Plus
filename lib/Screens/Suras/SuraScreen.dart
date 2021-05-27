import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
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
      body: FutureBuilder(
        future: QuranAPI.getAllVersesOfSura(sura.number),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Verse> verses = snapshot.data;
            return ListView.separated(
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
    );
  }
}
