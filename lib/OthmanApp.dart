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
              icon: Icon(Icons.menu_book_sharp),
              title: "السور",
              activeColorPrimary: Color(0xff9E73D7),
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.person),
              title: "الشخصيات",
              activeColorPrimary: Color(0xff9E73D7),
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.location_on_rounded),
              title: "الأماكن",
              activeColorPrimary: Color(0xff9E73D7),
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.event_sharp),
              title: "الاحداث",
              activeColorPrimary: Color(0xff9E73D7),
              inactiveColorPrimary: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
