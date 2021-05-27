import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/SuraDetails.dart';
import 'package:othman/Screens/Suras/SuraScreen.dart';
import 'package:othman/models/Sura.dart';

class SuraTile extends StatelessWidget {
  final Sura sura;
  SuraTile({this.sura});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(context);
      },
      child: ListTile(
        tileColor: Colors.indigoAccent.withOpacity(0.3),
        title: Row(
          children: [
            Text(
              'رقم السورة: ${sura.number}',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 13),
            ),
            Spacer(),
            Text(
              sura.name,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        subtitle: Row(
          children: [
            GestureDetector(
              onTap: () {
                showSuraDetails(context, sura);
              },
              child: Icon(
                Icons.info_outline_rounded,
                size: 20,
              ),
            ),
            Spacer(),
            Text(
              'عدد الايات: ${sura.numberOfVerses}',
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  void onTap(context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SuraScreen(sura: sura);
      },
    ));
  }
}
