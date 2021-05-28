import 'package:flutter/material.dart';
import 'package:othman/Screens/Characters/CharacterScreen.dart';
import 'package:othman/models/Character.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  CharacterTile({this.character});

  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CharacterScreen(character: character);
            },
          ));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorDark,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  character.name,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
