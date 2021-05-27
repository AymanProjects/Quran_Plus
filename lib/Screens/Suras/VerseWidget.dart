import 'package:flutter/material.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';
import 'package:othman/Screens/Suras/VerseDetails.dart';
import 'package:quran/quran.dart';

class VerseWidget extends StatelessWidget {
  final Verse verse;
  VerseWidget({@required this.verse});

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
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }
}
