import 'package:flutter/material.dart';

class SuraNumber extends StatelessWidget {
  final int suraNumber;

  SuraNumber({this.suraNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/SuraNumber.png',
            color: Theme.of(context).primaryColor,
            width: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              suraNumber.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
