import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_moneyqularavel/constants/Theme.dart';

//widgets
import 'package:flutter_moneyqularavel/widgets/navbar.dart';
import 'package:flutter_moneyqularavel/widgets/input.dart';

import 'package:flutter_moneyqularavel/widgets/drawer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: ""),
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
                              height: MediaQuery.of(context).size.height * 0.15,
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
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text("Login",
                                            style: TextStyle(
                                                color: FlutterMoneyquColors.text,
                                                fontSize: 16.0)),
                                      )),
                                  // Divider()
                                ],
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.63,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
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
                                            child: Input(
                                                placeholder: "Email",
                                                prefixIcon: Icon(Icons.email)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: "Password",
                                                prefixIcon: Icon(Icons.lock)),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: FlutterMoneyquColors.white,
                                            color: FlutterMoneyquColors.primary,
                                            onPressed: () {
                                              // Respond to button press
                                              Navigator.pushNamed(
                                                  context, '/home');
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 8,
                                                    bottom: 8),
                                                child: Text("Login",
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
}
