import 'package:flutter/material.dart';
import 'package:othman/Screens/Locations/LocationScreen.dart';
import 'package:othman/Services/QuranAPI.dart';
import 'package:othman/components/EpicTile.dart';
import 'package:othman/components/SearchBar.dart';
import 'package:othman/models/Location.dart';

class AllLocationsScreen extends StatefulWidget {
  @override
  _AllLocationsScreenState createState() => _AllLocationsScreenState();
}

class _AllLocationsScreenState extends State<AllLocationsScreen> {
  List<Location> allLocations = [];
  List<Location> locations = [];

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'جميع الأماكن',
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
              SizedBox(height: 15),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  children: locations.map((Location location) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: EpicTile(
                        Icons.location_on_rounded,
                        title: location.name,
                        onClick: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return LocationScreen(location);
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
