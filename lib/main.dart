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
import 'package:flutter_moneyqularavel/screens/simpanan.dart';
import 'package:flutter_moneyqularavel/screens/laporan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/tambahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/simpanan/tambahsimpanan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pengeluaran/tambahpengeluaran.dart';
import 'package:flutter_moneyqularavel/screens/crud/hutang/tambahhutang.dart';
import 'package:flutter_moneyqularavel/screens/crud/piutang/tambahpiutang.dart';
import 'package:flutter_moneyqularavel/screens/crud/tujuankeuangan/tambahtujuankeuangan.dart';

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

          //route pemasukan
          "/pemasukan": (BuildContext context) => new Pemasukan(),
          "/tambah-pemasukan": (BuildContext context) => new Tambahpemasukan(),
          //end pemasukan

          //route pemasukan
          "/pengeluaran": (BuildContext context) => new Pengeluaran(),
          "/tambah-pengeluaran": (BuildContext context) => new Tambahpengeluaran(),
          //end pemasukan

          //route tujuan keuangan
          "/TujuanKeuangan": (BuildContext context) => new TujuanKeuangan(),
          "/tambah-tujuan-keuangan": (BuildContext context) => new Tambahtujuankeuangan(),
          //end tujuan keuangan

          //route tambah hutang
          "/hutang": (BuildContext context) => new Hutang(),
          "/tambah-hutang": (BuildContext context) => new Tambahhutang(),

          //route tambah piutang
          "/piutang": (BuildContext context) => new Piutang(),
          "/tambah-piutang": (BuildContext context) => new Tambahpiutang(),

          "/laporan": (BuildContext context) => new Laporan(),

          "/simpanan": (BuildContext context) => new Simpanan(),
          "/tambah-simpanan": (BuildContext context) => new Tambahsimpanan(),

          "/pro": (BuildContext context) => new Pro(),
        });
  }
}
