import 'package:flutter/material.dart';

class EpicDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 25,
      thickness: 1,
      endIndent: 40,
      indent: 40,
    );
  }
}
