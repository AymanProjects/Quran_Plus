import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/CharacterTile.dart';
import 'package:othman/components/SearchBar.dart';
import 'package:othman/models/Character.dart';

class AllCharactersScreen extends StatefulWidget {
  @override
  _AllCharactersScreenState createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends State<AllCharactersScreen> {
  List<Character> allCharacters = [];
  List<Character> characters = [];

  void loadCharacters() async {
    await QuranAPI.getAllCharacters().then((value) {
      allCharacters = value;
      setState(() {
        characters = allCharacters;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text('جميع الشخصيات', textDirection: TextDirection.rtl),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SearchBar(
              hint: "اسم الشخصية",
              onChange: (value) {
                setState(() {
                  if (value.isEmpty) {
                    characters = allCharacters;
                  } else
                    characters = allCharacters
                        .where((sura) => sura.name.contains(value))
                        .toList();
                });
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5),
                children: characters.map((Character character) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CharacterTile(character: character),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
