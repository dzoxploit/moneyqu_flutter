import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.category = "",
      this.harga = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
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
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category,
                              style: TextStyle(
                                  color: FlutterMoneyquColors.header, fontSize: 13
                              )),
                          Text(title,
                              style: TextStyle(
                                  color: FlutterMoneyquColors.header, fontSize: 16)),
                          Text(harga,
                              style: TextStyle(
                                  color: FlutterMoneyquColors.Tambah, fontSize: 13)),
                        Text(cta,
                              style: TextStyle(
                                  color: FlutterMoneyquColors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
