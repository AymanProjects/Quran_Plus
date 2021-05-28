import 'package:flutter/material.dart';
import 'package:othman/Screens/Suras/SuraDetails.dart';
import 'package:othman/Screens/Suras/SuraScreen.dart';
import 'package:othman/components/SuraNumberWidget.dart';
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
      child: Container(
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showSuraDetails(context, sura);
                  },
                  child: Center(
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sura.name,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${sura.type}',
                      textDirection: TextDirection.rtl,
                    ),
                    Text(" | "),
                    Text(
                      'عدد الايات ${sura.numberOfVerses}',
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SuraNumber(
                  suraNumber: sura.number,
                )
              ],
            )
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
