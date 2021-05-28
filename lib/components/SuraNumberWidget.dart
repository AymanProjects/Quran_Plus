import 'package:flutter/material.dart';

class SuraNumber extends StatelessWidget {
  final int suraNumber;

  SuraNumber({this.suraNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 40,
      height: 40,
      child: Container(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/SuraNumber.png',
                  width: 40,
                ),
                Text(
                  suraNumber.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//
