import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/VerseDetails.dart';
import 'package:othman/models/Verse.dart';
import 'package:quran/quran.dart';

class VerseWidget extends StatelessWidget {
  final Verse verse;
  final double fontSize;
  VerseWidget({@required this.verse, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showVerseDetails(context, verse);
      },
      child: Text(
        verse.verse + getVerseEndSymbol(verse.verseNumber),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.black, fontSize: fontSize ?? 23),
      ),
    );
  }
}
