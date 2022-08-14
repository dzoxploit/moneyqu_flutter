import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  String name='';
  var indexdata1;
  var calculation;
  var _items = [
    "Active",
    "Non Active",
  ];

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
  String _validateNama(String value) {
    if (value.length == 0) return 'Nama cannot be empty';
    return null;
  }
  String _validateNominal(String value) {
    if (value == null || value.isEmpty) return 'Nominal be empty';

    var value2 = calculation - int.parse(value);

    if (value2 < 0) return 'Jumlah pengeluaran tidak boleh lebih dari saldo';
    
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