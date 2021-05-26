import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:othman/Services/QuranAPI.dart';

import 'models/Verse.dart';

void main() async {
  WidgetsFlutterBinding();
  await QuranAPI.init();

  List<Verse> verses = await QuranAPI.getAllVersesOfSura(3);

  for (int i = 0; i < verses.length; i++) {
    // print(verses[i].verse);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Othman App')),
      body: SingleChildScrollView(
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
                            // textScaleFactor: 1.1,
                            textAlign: TextAlign.center,
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
      ),
      bottomNavigationBar: MoltenBottomNavigationBar(
        onTabChange: (index) {},
        selectedIndex: 0,
        tabs: [
          MoltenTab(icon: Icon(Icons.add_alarm)),
          MoltenTab(icon: Icon(Icons.access_alarms)),
          MoltenTab(icon: Icon(Icons.delete_sweep)),
          MoltenTab(icon: Icon(Icons.wine_bar)),
        ],
      ),
    );
  }
}
