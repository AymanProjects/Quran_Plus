import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/SuraDetails.dart';
import 'package:othman/Screens/Suras/VerseWidget.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/SearchBar.dart';
import 'package:othman/models/Sura.dart';
import 'package:othman/models/Verse.dart';

class SuraScreen extends StatefulWidget {
  final Sura sura;
  SuraScreen({this.sura});

  @override
  _SuraScreenState createState() => _SuraScreenState();
}

class _SuraScreenState extends State<SuraScreen> {
  List<Verse> allVerses = [];
  List<Verse> verses = [];
  double srearchBarHieght = 0;

  void loadVerses() async {
    await QuranAPI.getAllVersesOfSura(widget.sura.number).then((value) {
      allVerses = value;
      setState(() {
        verses = allVerses;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadVerses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.grey[200],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          widget.sura.name,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.search,
                                color: Colors.grey[100],
                              ),
                              onTap: () {
                                if (srearchBarHieght == 0)
                                  srearchBarHieght = null;
                                else
                                  srearchBarHieght = 0;
                                setState(() {});
                              },
                            ),
                            SizedBox(width: 12),
                            Builder(
                              builder: (context) {
                                return GestureDetector(
                                  child: Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.grey[200],
                                  ),
                                  onTap: () {
                                    showSuraDetails(context, widget.sura);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                height: srearchBarHieght,
                child: Opacity(
                  opacity: srearchBarHieght == 0 ? 0 : 1,
                  child: SearchBar(
                    hint: "ابحث عن آية",
                    onChange: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          verses = allVerses;
                        } else
                          verses = allVerses
                              .where((verse) => verse.verse.contains(value))
                              .toList();
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
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
                    return VerseWidget(
                      verse: verses[index],
                      fontSize: 26,
                    );
                  },
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
