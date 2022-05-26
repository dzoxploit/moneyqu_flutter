import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/screens/crud/tagihan/detailtagihan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/piutang/detailpiutang.dart';
import 'package:flutter_moneyqularavel/screens/crud/simpanan/detailsimpanan.dart';

class CardHorizontalTagihan extends StatelessWidget {


  CardHorizontalTagihan(
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
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70,
          ),
          height: 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 220,
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: nama_tagihan),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        jumlah_tagihan,
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
                              text: status_tagihan),
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
                            text: tanggal_tagihan),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
  }
}
