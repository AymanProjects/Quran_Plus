import 'package:flutter/material.dart';
import 'package:othman/Screens/Stories/StoryScreen.dart';
import 'package:othman/models/Story.dart';

class StoryTile extends StatelessWidget {
  final Story story;

  StoryTile(this.story);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return StoryScreen(story);
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
            Icons.book_online,
            color: Colors.white,
            size: 18,
          ),
          title: Row(
            children: [
              Spacer(),
              Text(
                story.name,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
