import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/detailpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/pengeluaran/detailpengeluaran.dart';

class CardHorizontalPengeluaran extends StatelessWidget {


  CardHorizontalPengeluaran(
      {this.title = "Placeholder Title",
        this.cta = "",
        this.category = "",
        this.harga = "",
        this.img = "https://via.placeholder.com/200",
        this.tap = defaultFunc,
        this.id_pengeluaran = 0,
      });

  final String cta;
  final int id_pengeluaran;
  final String category;
  final String harga;
  final String img;
  final Function tap;
  final String title;

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
          MaterialPageRoute(builder: (context) => Detailpengeluaran(id: id_pengeluaran)),
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
                              text: title),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        harga,
                        style: TextStyle(
                          fontSize: 15,
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
                              text: category),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
