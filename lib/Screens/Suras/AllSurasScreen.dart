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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('جميع السور',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  )),
              SizedBox(
                height: 20,
              ),
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
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1,
                      height: 0,
                    );
                  },
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemCount: suras.length,
                  itemBuilder: (context, index) {
                    return SuraTile(sura: suras[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
