import 'package:flutter/material.dart';
import 'package:othman/Screens/Sura/AllSurasScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class OthmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        body: PersistentTabView(
          context,
          navBarStyle: NavBarStyle.style6,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 100),
          ),
          screens: [
            AllSurasScreen(),
            AllSurasScreen(),
          ],
          items: [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              title: "Home",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              inactiveColorSecondary: Colors.purple,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              title: "Home",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              inactiveColorSecondary: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
