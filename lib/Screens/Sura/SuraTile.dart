import 'package:flutter/material.dart';
import 'package:othman/Screens/Sura/SuraScreen.dart';
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
        tileColor: Colors.amberAccent,
        title: Row(
          children: [
            Spacer(),
            Text(
              sura.name,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        subtitle: Row(
          children: [
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
