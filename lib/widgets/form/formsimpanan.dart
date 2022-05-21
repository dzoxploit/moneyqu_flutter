import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';

class AppFormsimpanan extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController deskripsiController;
  TextEditingController tujuansimpananController;
  TextEditingController jenissimpananController;
  TextEditingController jumlahsimpananController;

  AppFormsimpanan({this.formKey, this.deskripsiController, this.tujuansimpananController, this.jenissimpananController, this.jumlahsimpananController});

  @override
  _AppFormsimpananState createState() => _AppFormsimpananState();
}

class _AppFormsimpananState extends State<AppFormsimpanan> {
  String _validateDeskripsi(String value) {
    if (value.length == 0) return 'Nama Simpanan cannot be empty';
    return null;
  }
  String _validateTujuanSimpanan(String value) {
    if (value.length == 0) return 'Tujuan Simpanan cannot be empty';
    return null;
  }
  String _validateJenisSimpanan(String value) {
    if (value == null || value.isEmpty) return 'Jenis Simpanan cannot be empty';
    return null;
  }

  String _validateJumlahSimpanan(String value) {
    if (value == null || value.isEmpty) return 'Tanggal Jumlah Simpanan cannot be empty';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Nama Simpanan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.deskripsiController,
            validator: _validateDeskripsi,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Tujuan Simpanan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.tujuansimpananController,
            validator: _validateTujuanSimpanan,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Jenis Simpanan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.jenissimpananController,
            validator: _validateJenisSimpanan,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Jumlah Simpanan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.jumlahsimpananController,
            validator: _validateJenisSimpanan,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );;
  }
}
