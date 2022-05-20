import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';

class AppFormpemasukan extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namapemasukanController;
  TextEditingController kategoripemasukanController;
  TextEditingController jumlahpemasukanController;
  TextEditingController tanggalpemasukanController;
  TextEditingController keteranganController;

  AppFormpemasukan({this.formKey, this.namapemasukanController, this.kategoripemasukanController, this.jumlahpemasukanController, this.tanggalpemasukanController, this.keteranganController});

  @override
  _AppFormpemasukanState createState() => _AppFormpemasukanState();
}

class _AppFormpemasukanState extends State<AppFormpemasukan> {
  String _validateNamaPemasukan(String value) {
    if (value.length == 0) return 'Nama Pemasukan cannot be empty';
    return null;
  }
  String _validateKategoriPemasukan(String value) {
    if (value.length == 0) return 'Kategori Pemasukan cannot be empty';
    return null;
  }
  String _validateKeterangan(String value) {
    if (value == null || value.isEmpty) return 'Keterangan cannot be empty';
    return null;
  }

  String _validateTanggalPemasukan(String value) {
    if (value == null || value.isEmpty) return 'Tanggal Pemasukan cannot be empty';
    return null;
  }

  String _validateJumlahpemasukan(String value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Jumlah Pemasukan must be a number';
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
              labelText: "Nama Pemasukan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.namapemasukanController,
            validator: _validateNamaPemasukan,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Kategori Pemasukan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.kategoripemasukanController,
            validator: _validateKategoriPemasukan,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Jumlah Pemasukan (Rp)",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.jumlahpemasukanController,
            validator: _validateJumlahpemasukan,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            readOnly: true,
            controller: widget.tanggalpemasukanController,
            decoration: InputDecoration(
              labelText: 'Tanggal Pemasukan',
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
                  widget.tanggalpemasukanController.text =
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
