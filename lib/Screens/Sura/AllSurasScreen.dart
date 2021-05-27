import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/models/Sura.dart';

import 'SuraTile.dart';

class AllSurasScreen extends StatefulWidget {
  @override
  _AllSurasScreenState createState() => _AllSurasScreenState();
}

class _AllSurasScreenState extends State<AllSurasScreen> {
  List<Sura> allSuras = [];
  List<Sura> suras = [];

  double width;

  double height;

  void loadSuras() async {
    await QuranAPI.getAllSuras().then((value) {
      allSuras = value;
      setState(() {
        suras = allSuras;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadSuras();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text('جميع السور', textDirection: TextDirection.rtl),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: width * 0.9,
            height: 60,
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "اسم السورة",
                  hintTextDirection: TextDirection.rtl),
              textDirection: TextDirection.rtl,
              onChanged: (suraName) {
                setState(() {
                  if (suraName.isEmpty) {
                    suras = allSuras;
                  } else
                    suras = allSuras
                        .where((sura) => sura.name.contains(suraName))
                        .toList();
                });
              },
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              children: suras.map((Sura sura) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SuraTile(sura: sura),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
