import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:othman/Screens/Characters/AllCharactersScreen.dart';
import 'package:othman/Screens/Locations/AllLocationsScreen.dart';
import 'package:othman/Screens/Stories/AllStoriesScreen.dart';
import 'package:othman/Screens/Suras/AllSurasScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class OthmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
    ));
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (scroll) {
        scroll.disallowGlow();
        return true;
      },
      child: Scaffold(
        body: PersistentTabView(
          context,
          navBarHeight: 60,
          bottomScreenMargin: 0,
          navBarStyle: NavBarStyle.style6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              icon: Icon(Icons.menu_book_rounded),
              activeColorPrimary: Theme.of(context).primaryColorDark,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.person),
              activeColorPrimary: Theme.of(context).primaryColorDark,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.location_on_rounded),
              activeColorPrimary: Theme.of(context).primaryColorDark,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.bookmark_rounded),
              activeColorPrimary: Theme.of(context).primaryColorDark,
              inactiveColorPrimary: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
