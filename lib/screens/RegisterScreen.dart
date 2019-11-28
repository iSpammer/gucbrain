import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gucbrain/api/api.dart';
import 'package:gucbrain/screens/home.dart';
import 'package:gucbrain/util/modal_progress_hud.dart';
import 'package:gucbrain/widgets/button.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name, email, mobile, password, age, nation;
  final _key = new GlobalKey<FormState>();
  bool _showSpinner = false;
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    print("asdd $nation");
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    } else {
      setState(() {
        _showSpinner = false;
      });
    }
  }

  save() async {


    var data = {
      "name": name,
      "email": email,
      "phone": mobile,
      "password": password,
      "age": age,
      "nation": nation,
    };

    var res = await CallApi().postData(data, 'register');
    var body = json.decode(res.body);
    print("meaaaw $body");
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      print("${json.encode(body['user'])} meaaaaaw");
      localStorage.setString('user', json.encode(body['user']));
      setState(() {
        Navigator.push(
            context,
            new CupertinoPageRoute(
                builder: (context) => Home()));
      });
      registerToast("Please login using $email");
    }
    else{
      registerToast("Error Ocured");

    }

    setState(() {
      _showSpinner = false;
    });

  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.grey,
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 50,
                          child: Text(
                            "Register",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        //card for Fullname TextFormField
                        Card(
                          elevation: 6.0,
                          child: TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert Full Name";
                              }
                            },
                            onSaved: (e) => name = e,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child:
                                      Icon(Icons.person, color: Colors.black),
                                ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "Fullname"),
                          ),
                        ),

                        //card for Email TextFormField
                        Card(
                          elevation: 6.0,
                          child: TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert Email";
                              }
                            },
                            onSaved: (e) => email = e,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.email, color: Colors.black),
                                ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "Email"),
                          ),
                        ),

                        //card for Mobile TextFormField
                        Card(
                          elevation: 6.0,
                          child: TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert Mobile Number";
                              }
                            },
                            onSaved: (e) => mobile = e,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phone, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Mobile",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        //card for Password TextFormField
                        Card(
                          elevation: 6.0,
                          child: TextFormField(
                            obscureText: _secureText,
                            onSaved: (e) => password = e,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Password Can't be Empty";
                              }
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.phonelink_lock,
                                      color: Colors.black),
                                ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "Password"),
                          ),
                        ),

                        //card for Age TextFormField
                        Card(
                          elevation: 6.0,
                          child: TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert Age Number";
                              }
                            },
                            onSaved: (e) => age = e,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.account_circle,
                                    color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Age",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        //card for Nation TextFormField
                        Card(
                          elevation: 6.0,

                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 15),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: nation,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  nation = newValue;
                                });
                              },
                              hint: Row(
                                children: <Widget>[
                                  Icon(Icons.supervisor_account),
                                  Text("Please Select your Nation"),
                                ],
                              ),
                              items: <String>[
                                'Egypt',
                                'Syria',
                                'Hell',
                                'GUC'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),

//                          child: TextFormField(
//                            validator: (e) {
//                              if (e.isEmpty) {
//                                return "Please Enter your nation";
//                              }
//                            },
//                            onSaved: (e) => mobile = e,
//                            style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 16,
//                              fontWeight: FontWeight.w300,
//                            ),
//                            decoration: InputDecoration(
//                              prefixIcon: Padding(
//                                padding: EdgeInsets.only(left: 20, right: 15),
//                                child: Icon(Icons.supervisor_account,
//                                    color: Colors.black),
//                              ),
//                              contentPadding: EdgeInsets.all(18),
//                              labelText: "Nation",
//                            ),
//                            keyboardType: TextInputType.text,
//                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(12.0),
                        ),
                        Hero(
                          tag: "register",
                          child: new Button(
                            text: "Register",
                            color: Colors.blue,
                            fn: () {
                              setState(() {
                                _showSpinner = true;
                              });
                              check();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
