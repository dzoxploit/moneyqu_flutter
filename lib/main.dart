import 'package:flutter/material.dart';

// screens
import 'package:flutter_moneyqularavel/screens/onboarding.dart';
import 'package:flutter_moneyqularavel/screens/pro.dart';
import 'package:flutter_moneyqularavel/screens/home.dart';
import 'package:flutter_moneyqularavel/screens/profile.dart';
import 'package:flutter_moneyqularavel/screens/login.dart';
import 'package:flutter_moneyqularavel/screens/register.dart';
import 'package:flutter_moneyqularavel/screens/articles.dart';
import 'package:flutter_moneyqularavel/screens/elements.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Argon PRO Flutter',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/onboarding",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/home": (BuildContext context) => new Home(),
          "/login": (BuildContext context) => new Login(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register(),
          "/pro": (BuildContext context) => new Pro(),
        });
  }
}
