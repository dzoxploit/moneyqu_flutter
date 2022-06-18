import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';

class AppEdittujuankeuangan extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namatujuankeuanganController;
  TextEditingController kategoritujuankeuanganController;
  TextEditingController tanggalController;
  TextEditingController nominalController;
  TextEditingController hutangController;
  TextEditingController simpananController;

  AppEdittujuankeuangan({this.formKey, this.namatujuankeuanganController,this.kategoritujuankeuanganController, this.tanggalController, this.nominalController, this.hutangController, this.simpananController});

  @override
  _AppEdittujuankeuanganState createState() => _AppEdittujuankeuanganState();
}

class _AppEdittujuankeuanganState extends State<AppEdittujuankeuangan> {
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  var _items = [
    "Active",
    "Non Active",
  ];

  static String baseUrl = "/kategori-tujuan-keuangan";
  static String baseUrl2 = "/hutang";
  static String baseUrl3 = "/simpanan";

  List _dataKategori = [];
  List _dataHutang = [];
  List _dataSimpanan = [];
  String valKategori;
  int  _valHutang;
  int _valSimpanan;

  Future<void> _getKategori() async {
    final response = await Network().getData(baseUrl);
    var indexdata = json.decode(response.body)['data'];
    setState(() {
      _dataKategori = indexdata;
      _valHutang = int.parse(widget.hutangController.text);
      _valSimpanan = int.parse(widget.simpananController.text);
      valKategori = widget.kategoritujuankeuanganController.text;
    });
  }

  Future<void> _getHutang() async {
    final response = await Network().getData(baseUrl2);
    var indexdata = json.decode(response.body)['data']['data_hutang'];
    setState(() {
      _dataHutang = indexdata;
    });
  }

  Future<void> _getSimpanan() async {
    final response = await Network().getData(baseUrl3);
    var indexdata = json.decode(response.body)['data']['data_simpanan'];
    setState(() {
      _dataSimpanan = indexdata;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _getKategori();
    _getSimpanan();
    _getHutang();
  }
  String _validateNamaTujuanKeuangan(String value) {
    if (value.length == 0) return 'Nama Tujuan Keuangan cannot be empty';
    return null;
  }
  String _validateNominal(String value) {
    if (value == null || value.isEmpty) return 'Nominal be empty';
    return null;
  }

  String _validateKategoriTujuanKeuangan(String value) {
    if (value == null || value.isEmpty) return 'Tanggal cannot be empty';
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: _autovalidate,
      child: Column(
        children:<Widget>[
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Nama Tujuan Keuangan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.namatujuankeuanganController,
            validator: _validateNamaTujuanKeuangan,
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
                hint: Text("Kategori Tujuan Keuangan"),
                value: valKategori,
                items: _dataKategori.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['nama_tujuan_keuangan']),
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    valKategori = value;
                    widget.kategoritujuankeuanganController.text = value;
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
                labelText: "Kategori ",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              controller: widget.kategoritujuankeuanganController,
              validator: _validateKategoriTujuanKeuangan,
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
                hint: Text("Hutang"),
                value: _valHutang == null ? null : _dataHutang[_valHutang],
                items: _dataHutang.map((value) {
                  return DropdownMenuItem(
                      child: Text(value['nama_hutang']),
                      value: value
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valHutang = _dataHutang.indexOf(value);
                    widget.hutangController.text = value['id'].toString();
                    widget.nominalController.text = value['jumlah_hutang'].toString();
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
                labelText: "Hutang ",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              controller: widget.hutangController,
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
                hint: Text("Simpanan"),
                value: _valSimpanan == null ? null : _dataSimpanan[_valSimpanan],
                items: _dataSimpanan.map((value) {
                  return DropdownMenuItem(
                      child: Text(value['deskripsi']),
                      value: value
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valSimpanan= _dataSimpanan.indexOf(value);
                    widget.simpananController.text = value['id'].toString();
                    widget.nominalController.text = value['jumlah_simpanan'].toString();
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
                labelText: "Simpanan",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              controller: widget.simpananController,
              keyboardType: TextInputType.number,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
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
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            readOnly: true,
            controller: widget.tanggalController,
            decoration: InputDecoration(
              labelText: 'Tanggal',
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
            ),
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015),
                lastDate: DateTime(2025),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  widget.tanggalController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}