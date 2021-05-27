import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hint;
  final Function(String) onChange;
  SearchBar({this.hint, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
        ),
        textDirection: TextDirection.rtl,
        onChanged: (value) {
          onChange(value);
        },
      ),
    );
  }
}
