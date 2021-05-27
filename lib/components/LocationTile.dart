import 'package:flutter/material.dart';
import 'package:othman/Screens/Locations/LocationScreen.dart';
import 'package:othman/models/Location.dart';

class LocationTile extends StatelessWidget {
  final Location location;

  LocationTile(this.location);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return LocationScreen(location);
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
            Icons.home_work_sharp,
            color: Colors.white,
            size: 17,
          ),
          title: Row(
            children: [
              Spacer(),
              Text(
                location.name,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
