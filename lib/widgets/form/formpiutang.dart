import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_moneyqularavel/network/api.dart';

class AppFormpiutang extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namapiutangController;
  TextEditingController deksripsiController;
  TextEditingController noteleponController;
  TextEditingController jumlahhutangController;
  TextEditingController tanggalpiutangController;

  AppFormpiutang({this.formKey, this.namapiutangController, this.deksripsiController, this.noteleponController, this.jumlahhutangController, this.tanggalpiutangController});

  @override
  _AppFormpiutangState createState() => _AppFormpiutangState();
}

class _AppFormpiutangState extends State<AppFormpiutang> {
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

  String _validateNamaHutang(String value) {
    if (value.length == 0) return 'Nama Hutang cannot be empty';
    return null;
  }
  String _validateDeksripsiHutang(String value) {
    if (value.length == 0) return 'Deksripsi Hutang cannot be empty';
    return null;
  }
  String _validateJumlahHutang(String value) {
    if (value == null || value.isEmpty) return 'Jumlah Hutang be empty';

    var value2 = calculation - int.parse(value);

    if (value2 < 0) return 'Jumlah pengeluaran tidak boleh lebih dari saldo';

    return null;
  }

  String _validateTanggalHutang(String value) {
    if (value == null || value.isEmpty) return 'Tanggal Hutang cannot be empty';
    return null;
  }

  String _validateNoTelepon(String value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'No telepon must be a number';
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
              labelText: "Nama Piutang",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.namapiutangController,
            validator: _validateNamaHutang,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Deksripsi Piutang",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.deksripsiController,
            validator: _validateDeksripsiHutang,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Jumlah Piutang (Rp)",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.jumlahhutangController,
            validator: _validateJumlahHutang,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            readOnly: true,
            controller: widget.tanggalpiutangController,
            decoration: InputDecoration(
              labelText: 'Tanggal Piutang',
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
                  widget.tanggalpiutangController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                }
              });
            },
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "No telepon",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.noteleponController,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
            validator: _validateNoTelepon,
          ),
        ],
      ),
    );;
  }
}
