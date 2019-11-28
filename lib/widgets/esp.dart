import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gucbrain/screens/detail_page.dart';
class Esp extends StatefulWidget {
  final String name;
  final String temp;
  String flame = "NAN";
  String smoke = "NAN";


  Esp({Key key, this.name, this.temp, this.flame, this.smoke}) : super(key: key);

  @override
  _EspState createState() => _EspState();
}

class _EspState extends State<Esp> {
  static Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        onTap: ()=>Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => DetailsPage(mac: widget.name,temp: widget.temp, flame: widget.flame, smoke: widget.smoke,)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/esp.png",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${widget.name}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Temperature: ${widget.temp}C\nFlame Level: ${widget.flame}\nSmoke: ${widget.smoke}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text(
                    r"Temps in Celcius",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green[400],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class LinearToken {
  final int day;
  final int value;

  LinearToken(this.day, this.value);
}
