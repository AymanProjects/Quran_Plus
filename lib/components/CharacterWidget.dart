import 'package:flutter/material.dart';
import 'package:othman/models/Character.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  CharacterWidget(this.character);

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        trailing: Icon(
          Icons.person,
          color: Colors.white,
          size: 20,
        ),
        title: Row(
          children: [
            Spacer(),
            Text(
              character.name,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
