import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_moneyqularavel/constants/Theme.dart';

import 'package:flutter_moneyqularavel/widgets/drawer-tile.dart';

class FlutterMoneyquDrawer extends StatelessWidget {
  final String currentPage;

  FlutterMoneyquDrawer({this.currentPage});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: FlutterMoneyquColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Image.asset("assets/img/favpng_money-logo.png"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushReplacementNamed(context, '/home');
                  },
                  iconColor: FlutterMoneyquColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Pemasukan")
                      Navigator.pushReplacementNamed(context, '/pemasukan');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Pemasukan",
                  isSelected: currentPage == "Pemasukan" ? true : false),
              DrawerTile(
                  icon: Icons.account_balance_wallet_outlined,
                  onTap: () {
                    if (currentPage != "Pengeluaran")
                      Navigator.pushReplacementNamed(context, '/pengeluaran');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Pengeluaran",
                  isSelected: currentPage == "Pengeluaran" ? true : false),
              DrawerTile(
                icon: Icons.account_balance_wallet_sharp,
                onTap: () {
                  if (currentPage != "Hutang")
                    Navigator.pushReplacementNamed(context, '/hutang');
                },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Hutang",
                  isSelected: currentPage == "Hutang" ? true : false
              ),
              DrawerTile(
                  icon: Icons.settings_input_component,
                  onTap: () {
                    if (currentPage != "Piutang")
                      Navigator.pushReplacementNamed(context, '/piutang');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Piutang",
                  isSelected: currentPage == "Piutang" ? true : false),
              DrawerTile(
                  icon: Icons.verified_user,
                  onTap: () {
                    if (currentPage != "TujuanKeuangan")
                      Navigator.pushReplacementNamed(context, '/TujuanKeuangan');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Tujuan Keuangan",
                  isSelected: currentPage == "TujuanKeuangan" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (currentPage != "Articles")
                      Navigator.pushReplacementNamed(context, '/articles');
                  },
                  iconColor: FlutterMoneyquColors.primary,
                  title: "Articles",
                  isSelected: currentPage == "Articles" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle_rounded,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.pushReplacementNamed(context, '/profile');
                  },
                  iconColor: FlutterMoneyquColors.primary,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
            ],

          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: FlutterMoneyquColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.airplanemode_active,
                      onTap: _launchURL,
                      iconColor: FlutterMoneyquColors.muted,
                      title: "Getting Started",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }

}
