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
  final _dateController = TextEditingController();
  String _validateName(String value) {
    if (value.length < 3) return 'Name must be more than 2 charater';
    return null;
  }

  String _validateJumlahpemasukan(String value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Age must be a number';
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
            validator: (val) {
              if(val.length==0) {
                return "Nama Pemasukan cannot be empty";
              }else{
                return null;
              }
            },
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
            validator: (val) {
              if(val.length==0) {
                return "Kategori Pemasukan cannot be empty";
              }else{
                return null;
              }
            },
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
            validator: (val) {
              if(val.length==0) {
                return "Jumlah Pemasukan cannot be empty";
              }else{
                return null;
              }
            },
            keyboardType: TextInputType.number,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            readOnly: true,
            controller: _dateController,
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
                  _dateController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                }
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter date.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: FlatButton(
                textColor: FlutterMoneyquColors.white,
                color: FlutterMoneyquColors.primary,
                onPressed: () {
                  // Respond to button press
                  Navigator.pushNamed(
                      context, '/home');
                },
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(4.0),
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8,
                        bottom: 8),
                    child: Text("Login",
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w600,
                            fontSize: 16.0))),
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
