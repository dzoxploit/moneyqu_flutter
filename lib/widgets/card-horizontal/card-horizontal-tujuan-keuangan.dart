import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/screens/crud/tagihan/detailtagihan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/piutang/detailpiutang.dart';
import 'package:flutter_moneyqularavel/screens/crud/simpanan/detailsimpanan.dart';

class CardHorizontalTujuankeuangan extends StatelessWidget {


  CardHorizontalTujuankeuangan(
      {this.id_tujuan_keuangan  = "",
        this.nama = "",
        this.nominal = 0,
        this.nominal_goals = 0,
        this.percentage_goals = 0,
        this.nama_hutang = "",
        this.nama_simpanan = "",
        this.tanggal = "",
        this.status_tujuan_keuangan = "",
      });

  final int id_tujuan_keuangan;
  final String nama;
  final int nominal;
  final int nominal_goals;
  final int percentage_goals;
  final String nama_hutang;
  final String nama_simpanan;
  final String tanggal;
  final String status_tujuan_keuangan;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        splashColor: Colors.grey, // Splash color
        onTap: () =>  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detailtagihan(id: id_tujuan_keuangan)),
        ),
        child:  Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 85,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "",
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
                        "",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )
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
                              text: ""),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(fontSize: 13.0),
                        text: TextSpan(
                            style: TextStyle(color: Colors.lightBlue),
                            text: ""),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300),
                  ),
                  Container(
                    height: 5,
                    width: 340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color(0XFF00B686)),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}
