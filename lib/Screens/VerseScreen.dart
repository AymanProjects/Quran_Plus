import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/models/Verse.dart';
class VerseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
          child: Container(
              color: Colors.transparent,
              child: FutureBuilder(
                future: QuranAPI.getAllVersesOfSura(114),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Verse> verses = snapshot.data;
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                                children: verses
                                    .map(
                                      (Verse v) => TextSpan(
                                        text: v.verse +
                                            " ( " +
                                            v.verseNumber.toString() +
                                            " ) ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 30),
                                      ),
                                    )
                                    .toList()),
                          ),
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              )),
        ),
      );
  }
}