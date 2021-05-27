import 'package:flutter/material.dart';
import 'package:othman/models/Verse.dart';
import 'package:quran/quran.dart';
import 'package:stopper/stopper.dart';

class VerseWidget extends StatelessWidget {
  final Verse verse;
  VerseWidget({this.verse});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onVerseTap(context);
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
        ),
        Divider(
          height: 25,
          thickness: 1,
          endIndent: 35,
          indent: 35,
        ),
      ],
    );
  }

  void onVerseTap(context) {
    showStopper(
        context: context,
        stops: [400, 400],
        builder: (context, scrollController, scrollPhysics, stop) {
          return Container(
            color: Colors.pink,
            child: ListView(
              controller: scrollController,
              physics: scrollPhysics,
              children: [
                Text('ss'),
              ],
            ),
          );
        });
  }
}
