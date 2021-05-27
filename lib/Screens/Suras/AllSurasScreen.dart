import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/SearchBar.dart';
import 'package:othman/models/Sura.dart';

import '../../components/SuraTile.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text('جميع السور', textDirection: TextDirection.rtl),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SearchBar(
              hint: "اسم السورة",
              onChange: (value) {
                setState(() {
                  if (value.isEmpty) {
                    suras = allSuras;
                  } else
                    suras = allSuras
                        .where((sura) => sura.name.contains(value))
                        .toList();
                });
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5),
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
      ),
    );
  }
}
