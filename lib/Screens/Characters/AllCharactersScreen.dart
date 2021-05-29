import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/EpicTile.dart';
import 'package:othman/components/SearchBar.dart';
import 'package:othman/models/Character.dart';

import 'CharacterScreen.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'جميع الشخصيات',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
              SizedBox(height: 15),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  children: characters.map((Character character) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: EpicTile(
                        Icons.person,
                        title: character.name,
                        onClick: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CharacterScreen(character: character);
                            },
                          ));
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
