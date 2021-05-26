import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/models/Sura.dart';

class SurasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text('جميع السور', textDirection: TextDirection.rtl),
        ),
      ),
      body: FutureBuilder<List<Sura>>(
        future: QuranAPI.getAllSuras(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              children: snapshot.data.map((Sura sura) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.amberAccent,
                    title: Text(sura.name),
                    subtitle: Text('عدد الايات: ${sura.numberOfVerses}'),
                  ),
                );
              }).toList(),
            );
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
