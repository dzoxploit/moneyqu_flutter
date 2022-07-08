import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';

class AppEdittagihan extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namatagihanController;
  TextEditingController kategoritagihanController;
  TextEditingController notagihanController;
  TextEditingController norekeningController;
  TextEditingController jumlahtagihanController;
  TextEditingController statustagihanController;
  TextEditingController statuslunasController;
  TextEditingController kodebankController;
  TextEditingController deskrispiController;
  TextEditingController tanggaltagihanController;

  AppEdittagihan({this.formKey, this.namatagihanController,this.tanggaltagihanController, this.deskrispiController, this.kategoritagihanController, this.norekeningController, this.notagihanController, this.statustagihanController, this.jumlahtagihanController, this.kodebankController, this.statuslunasController});

  @override
  _AppEdittagihanState createState() => _AppEdittagihanState();
}

class _AppEdittagihanState extends State<AppEdittagihan> {
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  var _items = [
    "Active",
    "Non Active",
  ];
  var _lunas = [
    "Lunas",
    "Belum Lunas",
  ];

  static String baseUrl = "/kategori-tagihan";
  List _dataKategori = [];
  String valKategori;
  Future<void> _getKategori() async {
    final response = await Network().getData(baseUrl);
    var indexdata = json.decode(response.body)['data'];
    setState(() {
      _dataKategori = indexdata;
      valKategori = widget.kategoritagihanController.text;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _getKategori();
  }
  String _validateNamaTagihan(String value) {
    if (value.length == 0) return 'Nama Hutang cannot be empty';
    return null;
  }
  String _validateDeksripsi(String value) {
    if (value.length == 0) return 'Deksripsi Hutang cannot be empty';
    return null;
  }
  String _validateJumlahTagihan(String value) {
    if (value == null || value.isEmpty) return 'Jumlah Hutang be empty';
    return null;
  }

  String _validateKategoriTagihan(String value) {
    if (value == null || value.isEmpty) return 'Tanggal Hutang cannot be empty';
    return null;
  }
  String _validateStatusTagihan(String value) {
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
              labelText: "Nama Tagihan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.namatagihanController,
            validator: _validateNamaTagihan,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Deksripsi Tagihan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.deskrispiController,
            validator: _validateDeksripsi,
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
                hint: Text("Kategori Tagihan"),
                value: valKategori,
                items: _dataKategori.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['nama_tagihan']),
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    valKategori = value;
                    widget.kategoritagihanController.text = value;
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
                labelText: "Kategori Tagihan",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              controller: widget.kategoritagihanController,
              validator: _validateKategoriTagihan,
              keyboardType: TextInputType.number,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Jumlah Tagihan (Rp)",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.jumlahtagihanController,
            validator: _validateJumlahTagihan,
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            readOnly: true,
            controller: widget.tanggaltagihanController,
            decoration: InputDecoration(
              labelText: 'Tanggal Tagihan',
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
                  widget.tanggaltagihanController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                }
              });
            },
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "No tagihan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.notagihanController,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
            validator: _validateNoTelepon,
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "No rekening",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.norekeningController,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Kode Bank",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            controller: widget.kodebankController,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          TextField(
            controller: widget.statustagihanController,
            decoration: InputDecoration(
              labelText: "Status Tagihan",
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  widget.statustagihanController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return _items
                      .map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          TextField(
            controller: widget.statuslunasController,
            decoration: InputDecoration(
              labelText: "Status Lunas",
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  widget.statuslunasController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return _lunas
                      .map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}