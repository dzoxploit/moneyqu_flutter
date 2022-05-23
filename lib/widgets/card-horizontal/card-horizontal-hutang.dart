import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/screens/crud/hutang/detailhutang.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/simpanan/detailsimpanan.dart';

class CardHorizontalHutang extends StatelessWidget {


  CardHorizontalHutang(
      {this.jumlah_hutang = "",
        this.tanggal_hutang = "",
        this.status_hutang = "",
        this.nama_hutang = "",
        this.img = "https://via.placeholder.com/200",
        this.tap = defaultFunc,
        this.id_hutang = 0,
      });

  final String tanggal_hutang;
  final int id_hutang;
  final String status_hutang;
  final String jumlah_hutang;
  final String img;
  final Function tap;
  final String nama_hutang;

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
          MaterialPageRoute(builder: (context) => Detailhutang(id: id_hutang)),
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
                              text: nama_hutang),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        jumlah_hutang,
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
                              text: status_hutang),
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
                        text: tanggal_hutang),
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
