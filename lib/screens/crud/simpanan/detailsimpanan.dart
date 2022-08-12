import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
import 'package:flutter_moneyqularavel/screens/crud/simpanan/ubahsimpanan.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'file:///C:/Users/didin/Documents/flutter_moneyqularavel/lib/widgets/card-horizontal/card-horizontal.dart';
import 'package:flutter_moneyqularavel/widgets/card-small.dart';
import 'package:flutter_moneyqularavel/widgets/card-square.dart';
import 'package:flutter_moneyqularavel/widgets/card-category.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_moneyqularavel/widgets/form/formpemasukan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';

class Detailsimpanan extends StatefulWidget implements PreferredSizeWidget {
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
  final int id;

  const Detailsimpanan(
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
        this.id = 0,
      });

  final double _prefferedHeight = 180.0;

  @override
  _DetailsimpananState createState() => _DetailsimpananState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _DetailsimpananState extends State<Detailsimpanan> {
  final _dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var indexdata;
  var id_simpanan;
  var deskripsi;
  var jumlah_simpanan;
  var tujuan_simpanan;
  var jenis_simpanan;
  var status_simpanan;

  String currency='';

  void initState(){
    super.initState();
    _loadUserData();
    _getSimpananById();
  }

  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var settingsdata = jsonDecode(localStorage.getString('settings'));

    if(settingsdata != null) {
      setState(() {
        currency = settingsdata['currency_id'].toString();
      });
    }
  }

  Future<void> _getSimpananById() async {
    final response = await Network().getData('/simpanan?id='+widget.id.toString());
    indexdata = json.decode(response.body)['data']['data_simpanan'];
    setState(() {
      id_simpanan = indexdata['id'];
      deskripsi = indexdata['deskripsi'];
      jumlah_simpanan = indexdata['jumlah_simpanan'].toString();
      tujuan_simpanan =  indexdata['nama_tujuan_simpanan'].toString();
      jenis_simpanan = indexdata['nama_jenis_simpanan'].toString();
      if(indexdata['status_simpanan'] == 1){
        status_simpanan = "Active";
      }else if(indexdata['status_simpanan'] == 0){
        status_simpanan = "Non Active";
      }
    });
  }
  void _deleteSimpanan() async {
    var data = null;
    var res = await Network().postData(data, '/simpanan/destroy/'+id_simpanan.toString());
    print(res.body);
    var body = json.decode(res.body);
    if(body['status'] == 201){
      Navigator.pushReplacementNamed(context, '/simpanan');
    }else{
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  // Http post request to create new data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "detail-pemasukan"),
      body:  Stack(
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
                            "Detail Simpanan",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.restore_from_trash_sharp, color: Colors.white),
                              tooltip: 'Increase volume by 10',
                              onPressed: () {
                                _deleteSimpanan();
                              }
                          ),
                        ],
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: "Nama Simpanan"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: " : "),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                        text: deskripsi),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: "Jumlah Simpanan"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: " : "),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                        text: "Rp. " + jumlah_simpanan.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: "Tujuan Simpanan"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: " : "),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                        text: tujuan_simpanan),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: "Jenis Simpanan"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        text: " : "),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 20),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                        text: jenis_simpanan),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 20.0),
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                    text: "Status Simpanan"),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 20.0),
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                    text: " : "),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 20),
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                    text: status_simpanan),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(

        onPressed:(){ Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ubahsimpanan(id: id_simpanan)),
        );},
        tooltip: 'Increment',
        child: new Icon(Icons.edit),
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