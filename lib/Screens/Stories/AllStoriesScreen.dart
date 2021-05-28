import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/LocationTile.dart';
import 'package:othman/components/SearchBar.dart';
import 'package:othman/components/StoryTile.dart';
import 'package:othman/models/Story.dart';

class AllStoriesScreen extends StatefulWidget {
  @override
  _AllStoriesScreenState createState() => _AllStoriesScreenState();
}

class _AllStoriesScreenState extends State<AllStoriesScreen> {
  List<Story> allStories = [];
  List<Story> stories = [];

  void loadStories() async {
    await QuranAPI.getAllStories().then((value) {
      allStories = value;
      setState(() {
        stories = allStories;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadStories();
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
                'جميع القصص',
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
                hint: "اسم القصة",
                onChange: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      stories = allStories;
                    } else
                      stories = allStories
                          .where((location) => location.name.contains(value))
                          .toList();
                  });
                },
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  children: stories.map((Story story) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: StoryTile(story),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
