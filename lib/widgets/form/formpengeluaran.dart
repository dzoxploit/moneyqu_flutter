import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';

class AppFormpengeluaran extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namapengeluaranController;
  TextEditingController kategoripengeluaranController;
  TextEditingController jumlahpengeluaranController;
  TextEditingController tanggalpengeluaranController;
  TextEditingController keteranganController;

  AppFormpengeluaran({this.formKey, this.namapengeluaranController, this.kategoripengeluaranController, this.jumlahpengeluaranController, this.tanggalpengeluaranController, this.keteranganController});

  @override
  _AppFormpengeluaranState createState() => _AppFormpengeluaranState();
}

class _AppFormpengeluaranState extends State<AppFormpengeluaran> {
  String _validateNamaPengeluaran(String value) {
    if (value.length == 0) return 'Nama Pengeluaran cannot be empty';
    return null;
  }
  String _validateKategoriPengeluaran(String value) {
    if (value.length == 0) return 'Kategori Pengeluaran cannot be empty';
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
              labelText: "Kategori Pengeluaran",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.kategoripengeluaranController,
            validator: _validateKategoriPengeluaran,
            keyboardType: TextInputType.number,
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
