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
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text('جميع الاحداث', textDirection: TextDirection.rtl),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SearchBar(
              hint: "اسم الحدث",
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5),
                children: stories.map((Story story) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: StoryTile(story),
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
