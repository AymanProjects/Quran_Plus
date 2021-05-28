import 'package:flutter/material.dart';

class EpicTile extends StatelessWidget {
  final String title;
  final Color color;
  final Function onClick;
  final IconData iconData;

  EpicTile(this.iconData, {this.title, this.color, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: color != null ? color : null,
            gradient: color == null
                ? LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18,
                    color: color == null
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                iconData,
                color: color == null
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
