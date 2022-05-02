import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/screens/hutang.dart';

// screens
import 'package:flutter_moneyqularavel/screens/onboarding.dart';
import 'package:flutter_moneyqularavel/screens/piutang.dart';
import 'package:flutter_moneyqularavel/screens/pro.dart';
import 'package:flutter_moneyqularavel/screens/home.dart';
import 'package:flutter_moneyqularavel/screens/profile.dart';
import 'package:flutter_moneyqularavel/screens/login.dart';
import 'package:flutter_moneyqularavel/screens/register.dart';
import 'package:flutter_moneyqularavel/screens/articles.dart';
import 'package:flutter_moneyqularavel/screens/pemasukan.dart';
import 'package:flutter_moneyqularavel/screens/pengeluaran.dart';
import 'package:flutter_moneyqularavel/screens/tujuan-keuangan.dart';
import 'package:flutter_moneyqularavel/screens/laporan.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MoneyQU',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/onboarding",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/home": (BuildContext context) => new Home(),
          "/login": (BuildContext context) => new Login(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/account": (BuildContext context) => new Register(),
          "/pemasukan": (BuildContext context) => new Pemasukan(),
          "/pengeluaran": (BuildContext context) => new Pengeluaran(),
          "/TujuanKeuangan": (BuildContext context) => new TujuanKeuangan(),
          "/hutang": (BuildContext context) => new Hutang(),
          "/piutang": (BuildContext context) => new Piutang(),
          "/laporan": (BuildContext context) => new Laporan(),
          "/pro": (BuildContext context) => new Pro(),
        });
  }
}
