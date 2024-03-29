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
                      Navigator.pushNamed(context, '/home');
                  },
                  iconColor: FlutterMoneyquColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Pemasukan")
                      Navigator.pushNamed(context, '/pemasukan');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Pemasukan",
                  isSelected: currentPage == "Pemasukan" ? true : false),
              DrawerTile(
                  icon: Icons.account_balance_wallet_outlined,
                  onTap: () {
                    if (currentPage != "Pengeluaran")
                      Navigator.pushNamed(context, '/pengeluaran');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Pengeluaran",
                  isSelected: currentPage == "Pengeluaran" ? true : false),
              DrawerTile(
                icon: Icons.account_balance_wallet_sharp,
                onTap: () {
                  if (currentPage != "Hutang")
                    Navigator.pushNamed(context, '/hutang');
                },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Hutang",
                  isSelected: currentPage == "Hutang" ? true : false
              ),
              DrawerTile(
                  icon: Icons.settings_input_component,
                  onTap: () {
                    if (currentPage != "Piutang")
                      Navigator.pushNamed(context, '/piutang');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Piutang",
                  isSelected: currentPage == "Piutang" ? true : false),
              DrawerTile(
                  icon: Icons.verified_user,
                  onTap: () {
                    if (currentPage != "Tujuan-keuangan")
                      Navigator.pushNamed(context, '/tujuan-keuangan');
                  },
                  iconColor: FlutterMoneyquColors.info,
                  title: "Tujuan Keuangan",
                  isSelected: currentPage == "Tujuan-keuangan" ? true : false),
              DrawerTile(
                  icon: Icons.money_outlined,
                  onTap: () {
                    if (currentPage != "Tagihan")
                      Navigator.pushNamed(context, '/tagihan');
                  },
                  iconColor: FlutterMoneyquColors.primary,
                  title: "Tagihan",
                  isSelected: currentPage == "Tagihan" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle_rounded,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.pushNamed(context, '/profile');
                  },
                  iconColor: FlutterMoneyquColors.primary,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.add_business,
                  onTap: () {
                    if (currentPage != "Simpanan")
                      Navigator.pushNamed(context, '/simpanan');
                  },
                  iconColor: FlutterMoneyquColors.primary,
                  title: "Simpanan",
                  isSelected: currentPage == "Simpanan" ? true : false),
              ]
          ),
        ),
      ]),
    ));
  }

}
