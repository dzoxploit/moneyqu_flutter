import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/screens/crud/tagihan/detailtagihan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/piutang/detailpiutang.dart';
import 'package:flutter_moneyqularavel/screens/crud/simpanan/detailsimpanan.dart';
import 'package:flutter_moneyqularavel/screens/crud/tujuankeuangan/detailgoalstujuankeuangan.dart';
import 'package:flutter_moneyqularavel/screens/crud/tujuankeuangan/detailtujuankeuangan.dart';

class CardHorizontalGoalsTujuanKeuangan extends StatelessWidget {


  CardHorizontalGoalsTujuanKeuangan(
      {this.id_goals_tujuan_keuangan  = 0,
        this.nama = "",
        this.nominal = 0,
        this.tanggal = "",
      });

  final int id_goals_tujuan_keuangan;
  final String nama;
  final int nominal;
  final String tanggal;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        nama,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Rp."+nominal.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 220,
                        child:  RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: 13.0),
                          text: TextSpan(
                              style: TextStyle(color: Colors.lightBlue),
                              text: tanggal),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
