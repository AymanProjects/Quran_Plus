import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hint;
  final Function(String) onChange;
  SearchBar({this.hint, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          hintText: hint,
          hintStyle:
              TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
          hintTextDirection: TextDirection.rtl,
        ),
        style: TextStyle(fontSize: 20, color: Colors.black),
        textDirection: TextDirection.rtl,
        onChanged: (value) {
          onChange(value);
        },
      ),
    );
  }
}
