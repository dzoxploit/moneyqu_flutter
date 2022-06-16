import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';

class AppFormgoalstujuankeuangan extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namaController;
  TextEditingController nominalController;

  AppFormgoalstujuankeuangan({this.formKey, this.namaController,this.nominalController});

  @override
  _AppFormgoalstujuankeuanganState createState() => _AppFormgoalstujuankeuanganState();
}

class _AppFormgoalstujuankeuanganState extends State<AppFormgoalstujuankeuangan> {
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  var _items = [
    "Active",
    "Non Active",
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String _validateNama(String value) {
    if (value.length == 0) return 'Nama cannot be empty';
    return null;
  }
  String _validateNominal(String value) {
    if (value == null || value.isEmpty) return 'Nominal be empty';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: _autovalidate,
      child: Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Nama",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.namaController,
            validator: _validateNama,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Nominal (Rp)",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.nominalController,
            validator: _validateNominal,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }
}