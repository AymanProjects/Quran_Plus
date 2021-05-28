import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/models/Location.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';

class LocationScreen extends StatelessWidget {
  final Location location;

  LocationScreen(this.location);
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
          location.name,
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
              children: [
                SizedBox(height: 10),
                Text(
                  'آيات ذكر بها المكان',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 12),
                FutureBuilder(
                  future: QuranAPI.getAllVersesOfLocation(location.id),
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
                                future:
                                    QuranAPI.getSura(verses[index].suraNumber),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      "${snapshot.data.name}",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
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
