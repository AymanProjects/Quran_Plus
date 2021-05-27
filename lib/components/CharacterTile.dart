import 'package:flutter/material.dart';
import 'package:othman/Screens/Characters/CharacterScreen.dart';
import 'package:othman/models/Character.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  CharacterTile({this.character});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return CharacterScreen(character: character);
          },
        ));
      },
      child: Card(
        color: Colors.white.withOpacity(0.01),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: ListTile(
          trailing: Icon(
            Icons.person,
            color: Colors.white,
            size: 20,
          ),
          title: Text(
            character.name,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
