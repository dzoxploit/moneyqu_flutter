import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AppFormBayarHutang extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namapengeluaranController;
  TextEditingController kategoripengeluaranController;
  TextEditingController jumlahpengeluaranController;
  TextEditingController tanggalpengeluaranController;
  TextEditingController keteranganController;

  AppFormBayarHutang({this.formKey, this.namapengeluaranController, this.kategoripengeluaranController, this.jumlahpengeluaranController, this.tanggalpengeluaranController, this.keteranganController});

  @override
  _AppFormBayarHutangState createState() => _AppFormBayarHutangState();
}

class _AppFormBayarHutangState extends State<AppFormBayarHutang> {
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String name='';
  var indexdata1;
  var calculation;
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
    _getIndex1();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }
  static String baseUrl2 = "/index";

  Future<void> _getIndex1() async {
    final response = await Network().getData(baseUrl2);
    indexdata1 = json.decode(response.body)['data'];
    setState(() {
      calculation = indexdata1['calculation'];
    });
  }

  String _validateNamaPengeluaran(String value) {
    if (value.length == 0) return 'Nama Pengeluaran cannot be empty';
    return null;
  }
  String _validateKeterangan(String value) {
    if (value == null || value.isEmpty) return 'Keterangan cannot be empty';
    return null;
  }

  String _validateTanggalPengeluaran(String value) {
    if (value == null || value.isEmpty) return 'Tanggal Pengeluaran cannot be empty';
    return null;
  }

  String _validateJumlahpengeluaran(String value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Jumlah Pengeluaran must be a number';
    var value2 = calculation - int.parse(value);

    if (value2 < 0) return 'Jumlah pengeluaran tidak boleh lebih dari saldo';

    return null;
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
              labelText: "Nama Pengeluaran",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.namapengeluaranController,
            validator: _validateNamaPengeluaran,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Jumlah Pengeluaran (Rp)",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.jumlahpengeluaranController,
            validator: _validateJumlahpengeluaran,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            readOnly: true,
            controller: widget.tanggalpengeluaranController,
            decoration: InputDecoration(
              labelText: 'Tanggal Pengeluaran',
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
                  widget.tanggalpengeluaranController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                }
              });
            },
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Keterangan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.keteranganController,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );;
  }
}
