import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';

class AppEditsimpanan extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController deskripsiController;
  TextEditingController tujuansimpananController;
  TextEditingController jenissimpananController;
  TextEditingController jumlahsimpananController;

  AppEditsimpanan({this.formKey, this.deskripsiController, this.tujuansimpananController, this.jenissimpananController, this.jumlahsimpananController});

  @override
  _AppEditsimpananState createState() => _AppEditsimpananState();
}

class _AppEditsimpananState extends State<AppEditsimpanan> {
  static String baseUrl = "/tujuan-simpanan";
  static String baseUrl2 = "/jenis-simpanan";
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  List _dataTujuanSimpanan = [];
  String valTujuanSimpanan;

  List _dataJenisSimpanan = [];
  String valJenisSimpanan;
  Future<void> _getTujuanSimpanan() async {
    final response = await Network().getData(baseUrl);
    var indexdata = json.decode(response.body)['data'];
    setState(() {
      _dataTujuanSimpanan = indexdata;
      valTujuanSimpanan = widget.tujuansimpananController.text;
    });
  }

  Future<void> _getJenisSimpanan() async {
    final response = await Network().getData(baseUrl);
    var indexdata = json.decode(response.body)['data'];
    setState(() {
      _dataJenisSimpanan = indexdata;
      valJenisSimpanan = widget.jenissimpananController.text;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTujuanSimpanan();
    _getJenisSimpanan();
  }
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
      autovalidateMode: _autovalidate,
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
          InputDecorator(
            decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child:  DropdownButton(
                hint: Text("Tujuan Simpanan"),
                value: valTujuanSimpanan,
                items: _dataTujuanSimpanan.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['nama_tujuan_simpanan']),
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    valTujuanSimpanan = value;
                    widget.tujuansimpananController.text = value;
                  });
                },
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new Visibility(
            visible: false,
            child: TextFormField(
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
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          InputDecorator(
            decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child:  DropdownButton(
                hint: Text("Jenis Simpanan"),
                value: valJenisSimpanan,
                items: _dataJenisSimpanan.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['nama_jenis_simpanan']),
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    valJenisSimpanan = value;
                    widget.jenissimpananController.text = value;
                  });
                },
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new Visibility(
            visible: false,
            child: TextFormField(
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
