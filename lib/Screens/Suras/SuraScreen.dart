import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/SuraDetails.dart';
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
      // appBar: AppBar(
      //   actions: [
      //     Builder(
      //       builder: (context) {
      //         return IconButton(
      //           icon: Icon(Icons.info_outline_rounded),
      //           onPressed: () {
      //             showSuraDetails(context, sura);
      //           },
      //         );
      //       },
      //     ),
      //   ],
      //   centerTitle: true,
      //   title: Text(
      //     sura.name,
      //     textDirection: TextDirection.rtl,
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColorDark,
                      ],
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        sura.name,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onTap: () {
                              showSuraDetails(context, sura);
                            },
                          ),
                          Spacer(),
                          Text(
                            "عدد الآيات | ${sura.numberOfVerses}",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: QuranAPI.getAllVersesOfSura(sura.number),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Verse> verses = snapshot.data;
                    return Expanded(
                      child: ListView.separated(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                          return VerseWidget(
                            verse: verses[index],
                            fontSize: 26,
                          );
                        },
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
