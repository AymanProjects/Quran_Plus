import 'package:flutter/material.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/LocationTile.dart';
import 'package:othman/components/SearchBar.dart';
import 'package:othman/models/Location.dart';

class AllLocationsScreen extends StatefulWidget {
  @override
  _AllLocationsScreenState createState() => _AllLocationsScreenState();
}

class _AllLocationsScreenState extends State<AllLocationsScreen> {
  List<Location> allLocations = [];
  List<Location> locations = [];

  double width;

  double height;

  void loadLocations() async {
    await QuranAPI.getAllLocations().then((value) {
      allLocations = value;
      setState(() {
        locations = allLocations;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text('جميع الأماكن', textDirection: TextDirection.rtl),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SearchBar(
              hint: "اسم المكان",
              onChange: (value) {
                setState(() {
                  if (value.isEmpty) {
                    locations = allLocations;
                  } else
                    locations = allLocations
                        .where((location) => location.name.contains(value))
                        .toList();
                });
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5),
                children: locations.map((Location location) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LocationTile(location),
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
