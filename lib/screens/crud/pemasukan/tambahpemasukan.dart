import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal.dart';
import 'package:flutter_moneyqularavel/widgets/card-small.dart';
import 'package:flutter_moneyqularavel/widgets/card-square.dart';
import 'package:flutter_moneyqularavel/widgets/card-category.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Tambahpemasukan extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String> tags;
  final Function getCurrentPage;
  final bool isOnSearch;
  final TextEditingController searchController;
  final Function searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  const Tambahpemasukan(
      {
        this.tags,
        this.transparent = false,
        this.rightOptions = true,
        this.getCurrentPage,
        this.searchController,
        this.isOnSearch = false,
        this.searchOnChanged,
        this.searchAutofocus = false,
        this.backButton = false,
        this.noShadow = false,
        this.bgColor = FlutterMoneyquColors.white,
      });

  final double _prefferedHeight = 180.0;

  @override
  _TambahpemasukanState createState() => _TambahpemasukanState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _TambahpemasukanState extends State<Tambahpemasukan> {
  final _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Tambah-pemasukan"),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/onboard-background.png"),
                        fit: BoxFit.cover)
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 10.0, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder (
                              builder: (context) => IconButton(
                                  icon: Icon(
                                      !widget.backButton
                                          ? Icons.menu
                                          : Icons.arrow_back_ios,
                                      color: !widget.transparent
                                          ? (widget.bgColor == FlutterMoneyquColors.white
                                          ? FlutterMoneyquColors.white
                                          : FlutterMoneyquColors.white)
                                          : FlutterMoneyquColors.white,
                                      size: 24.0),
                                  onPressed: () {
                                    if (!widget.backButton)
                                      Scaffold.of(context).openDrawer();
                                    else
                                      Navigator.pop(context);
                                  })
                          ),
                          Text(
                            "Create Pemasukan",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.grey.shade100,
                    child: SingleChildScrollView(
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
                    )
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector buildActivityButton(
      IconData icon, String title, Color backgroundColor, Color iconColor) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, '/home'
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}