import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/screens/crud/tagihan/detailtagihan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/piutang/detailpiutang.dart';
import 'package:flutter_moneyqularavel/screens/crud/simpanan/detailsimpanan.dart';

class CardHorizontalTujuankeuangan extends StatelessWidget {


  CardHorizontalTujuankeuangan(
      {this.jumlah_tagihan  = "",
        this.tanggal_tagihan = "",
        this.status_tagihan = "",
        this.nama_tagihan = "",
        this.no_tagihan = "",
        this.no_rekening = "",
        this.tap = defaultFunc,
        this.id_tagihan = 0,
      });

  final String tanggal_tagihan;
  final int id_tagihan;
  final String status_tagihan;
  final String jumlah_tagihan;
  final String no_tagihan;
  final String no_rekening;
  final Function tap;
  final String nama_tagihan;

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
          MaterialPageRoute(builder: (context) => Detailtagihan(id: id_tagihan)),
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
