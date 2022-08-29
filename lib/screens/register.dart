import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_moneyqularavel/constants/Theme.dart';

//widgets
import 'package:flutter_moneyqularavel/widgets/navbar-login-register.dart';

import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavbarLoginRegister(transparent: true, title: ""),
        extendBodyBehindAppBar: true,
        drawer: FlutterMoneyquDrawer(currentPage: "Account"),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.15,
                              decoration: BoxDecoration(
                                  color: FlutterMoneyquColors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: FlutterMoneyquColors.muted))),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0),
                                        child: Text("Register",
                                            style: TextStyle(
                                                color: FlutterMoneyquColors
                                                    .text,
                                                fontSize: 16.0)),
                                      )),
                                  // Divider()
                                ],
                              )),
                          Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.55,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: Color(0xFF000000)),
                                              cursorColor: Color(0xFF9b9b9b),
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.email,
                                                  color: Colors.grey,
                                                ),
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF9b9b9b),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .normal),
                                              ),
                                              validator: (emailValue) {
                                                if (emailValue.isEmpty) {
                                                  return 'Please enter email';
                                                }
                                                email = emailValue;
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: Color(0xFF000000)),
                                              cursorColor: Color(0xFF9b9b9b),
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.insert_emoticon,
                                                  color: Colors.grey,
                                                ),
                                                hintText: "Name",
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF9b9b9b),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .normal),
                                              ),
                                              validator: (name1) {
                                                if (name1.isEmpty) {
                                                  return 'Please enter your first name';
                                                }
                                                name = name1;
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: Color(0xFF000000)),
                                              cursorColor: Color(0xFF9b9b9b),
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.vpn_key,
                                                  color: Colors.grey,
                                                ),
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF9b9b9b),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .normal),
                                              ),
                                              validator: (passwordValue) {
                                                if (passwordValue.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                password = passwordValue;
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: FlutterMoneyquColors
                                                .white,
                                            color: FlutterMoneyquColors.primary,
                                            onPressed: () {
                                              // Respond to button press
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _register();
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text("REGISTER",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }
  void _register()async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': name,
      'email' : email,
      'password': password,
    };

    var res = await Network().auth(data, '/register');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      localStorage.setString('settings', json.encode(body['settings']));
      Navigator.pushReplacementNamed(context, '/home');
    }

    setState(() {
      _isLoading = false;
    });
  }
}
