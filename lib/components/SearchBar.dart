import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hint;
  final Function(String) onChange;
  SearchBar({this.hint, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.all(8),
          prefixIcon: Icon(Icons.search),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
          hintTextDirection: TextDirection.rtl,
        ),
        style: TextStyle(fontSize: 18, color: Colors.black),
        textDirection: TextDirection.rtl,
        onChanged: (value) {
          onChange(value);
        },
      ),
    );
  }
}
