import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gucbrain/screens/histories.dart';
import 'package:gucbrain/screens/esplist.dart';
import 'package:gucbrain/util/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userData;

  static Random random = Random();
  String name = "Ossama Akram";


  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
      ),


      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/user.png",),
              radius: 25,
            ),
            title: Text(name),
            subtitle: Text(name.toLowerCase().replaceAll(" ", ".")+"@gmail.com"),
          ),

          SizedBox(height: 20),

          Align(
            alignment: Alignment.center,
            child: DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TabBar(
                    isScrollable: false,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Theme.of(context)
                        .textTheme.caption.color,
                    tabs: <Widget>[
                      Tab(
                        text: "ESPs",
                      ),
                      Tab(
                        text: "History",
                      ),
                      Tab(
                        text: "Settings",
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height*2,
                    child: TabBarView(
                      children: <Widget>[
                        Esps(),
                        Histories(),
                        BuyandSell(),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
