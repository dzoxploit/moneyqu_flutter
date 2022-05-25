import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:intl/intl.dart';

class AppFormtagihan extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController namatagihanController;
  TextEditingController kategoritagihanController;
  TextEditingController notagihanController;
  TextEditingController norekeningController;
  TextEditingController jumlahtagihanController;
  TextEditingController statustagihanController;
  TextEditingController kodebankController;
  TextEditingController deskrispiController;
  TextEditingController tanggaltagihanController;

  AppFormtagihan({this.formKey, this.namatagihanController,this.tanggaltagihanController, this.deskrispiController, this.kategoritagihanController, this.norekeningController, this.notagihanController, this.statustagihanController, this.jumlahtagihanController, this.kodebankController});

  @override
  _AppFormtagihanState createState() => _AppFormtagihanState();
}

class _AppFormtagihanState extends State<AppFormtagihan> {
  var _items = [
    "Active",
    "Non Active",
  ];
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

  void initState() {
    // Get all countries
    super.initState();
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
          new TextFormField(
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
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
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
            controller: widget.norekeningController,
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
          )
        ],
      ),
    );
  }
}