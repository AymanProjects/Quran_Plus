import 'package:flutter/material.dart';
import 'package:othman/Screens/Characters/AllCharactersScreen.dart';
import 'package:othman/Screens/Locations/AllLocationsScreen.dart';
import 'package:othman/Screens/Stories/AllStoriesScreen.dart';
import 'package:othman/Screens/Suras/AllSurasScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class OthmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Color(0xff9E73D7),
        primaryColorDark: Color(0xff734DA4),
        fontFamily: 'Tajawal',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PersistentTabView(
          context,
          navBarStyle: NavBarStyle.style6,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 100),
          ),
          screens: [
            AllSurasScreen(),
            AllCharactersScreen(),
            AllLocationsScreen(),
            AllStoriesScreen(),
          ],
          items: [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.local_library_outlined),
              title: "السور",
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.person),
              title: "الشخصيات",
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home_work_rounded),
              title: "الأماكن",
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.book),
              title: "الاحداث",
              inactiveColorPrimary: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
