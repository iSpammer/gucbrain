import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gucbrain/api/api.dart';
import 'package:gucbrain/util/data.dart';
import 'package:gucbrain/widgets/esp.dart';

import 'package:http/http.dart' as http;

class Esps extends StatefulWidget {
  @override
  _EspsState createState() => _EspsState();
}

class _EspsState extends State<Esps> {
  bool isLoading = false;
  var espsloaded;

  static Future<List> _fetchEsps() async {
    Dio http = new Dio();
    final response = await http.get("${CallApi().url}/temps");
    print("alby $response");
    return json.decode(response.data.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchEsps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: _fetchEsps(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new EspLoader(
                  esps: snapshot.data,
                )
              : new Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
//      body: ListView.builder(
//        physics: NeverScrollableScrollPhysics(),
//        primary: false,
//        itemCount: espsloaded == null? 0 : espsloaded.length,
//        itemBuilder: (BuildContext context, int index) {
//
//          return Esp(
//            name: espsloaded['mac'],
//            temp: espsloaded['value'],
//          );
//        },
//      ),
    );
  }
}

class EspLoader extends StatefulWidget {
  final List esps;

  EspLoader({@required this.esps});

  @override
  _EspLoaderState createState() => _EspLoaderState();
}

class _EspLoaderState extends State<EspLoader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.esps);
    print("meaw");
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      itemCount: widget.esps.length,
      itemBuilder: (BuildContext context, int index) {
        return Esp(
          name: widget.esps[index]['mac'],
          temp: widget.esps[index]['value'],
          flame:  widget.esps[index]['flame'],
          smoke:  widget.esps[index]['smoke'],
        );
      },
    );
  }
}
