import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/widgets/form/edit/editpemasukan.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'file:///C:/Users/didin/Documents/flutter_moneyqularavel/lib/widgets/card-horizontal/card-horizontal.dart';
import 'package:flutter_moneyqularavel/widgets/card-small.dart';
import 'package:flutter_moneyqularavel/widgets/card-square.dart';
import 'package:flutter_moneyqularavel/widgets/card-category.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_moneyqularavel/widgets/form/edit/editsimpanan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';

class Ubahsimpanan extends StatefulWidget implements PreferredSizeWidget {
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

  const Ubahsimpanan(
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
        this.id = 0
      });

  final double _prefferedHeight = 180.0;

  @override
  _UbahsimpananState createState() => _UbahsimpananState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _UbahsimpananState extends State<Ubahsimpanan> {
  final _dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController deskripsiController;
  TextEditingController jumlahsimpananController;
  TextEditingController jenissimpananController;
  TextEditingController tujuansimpananController;
  TextEditingController statussimpananController;

  var indexdata;
  var id_pemasukan_data;
  var nama_pemasukan;
  var kategori_pemasukan;
  var jumlah_pemasukan;
  var tanggal_pemasukan;
  var keterangan;
  var status_simpanan;

  var deskripsi_edit;
  var jumlah_simpanan_edit;
  var tujuan_simpanan_edit;
  var jenis_simpanan_edit;

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
    final response = await Network().getData('/simpanan/update/'+widget.id.toString());
    indexdata = json.decode(response.body)['data'];
    setState(() {
      deskripsiController = TextEditingController(text: indexdata['deskripsi']);
      jumlahsimpananController = TextEditingController(text: indexdata['jumlah_simpanan'].toString());
      jenissimpananController = TextEditingController(text: indexdata['jenis_simpanan_id'].toString());
      tujuansimpananController = TextEditingController(text: indexdata['tujuan_simpanan_id'].toString());
      if(indexdata['status_tagihan'] == 1){
        statussimpananController = new TextEditingController(text: 'Active');
      }else if(indexdata['status_tagihan'] == 0){
        statussimpananController = new TextEditingController(text: 'Non Active');
      }
    });
  }

  // Http post request to create new data
  void _updateSimpanan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var settingsdata = jsonDecode(localStorage.getString('settings'));

    var data = {
      'deskripsi': deskripsiController.text,
      'jumlah_simpanan' : jumlahsimpananController.text,
      'currency_id': settingsdata['currency_id'],
      'tujuan_simpanan_id': tujuansimpananController.text,
      'jenis_simpanan_id': jenissimpananController.text,
      'status_simpanan': statussimpananController.text,
    };

    var res = await Network().postData(data, '/simpanan/update/'+widget.id.toString());
    print(res.body);
    var body = json.decode(res.body);
    if(body['status'] == 201){
      Navigator.pushReplacementNamed(context, '/simpanan');
    }else{
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "update-pemasukan"),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text("Update"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              _updateSimpanan();
            }
          },
        ),
      ),
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
                            "Update Pemasukan",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            " ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          )

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
                      child: AppEditsimpanan(
                        formKey: formKey,
                        deskripsiController: deskripsiController,
                        jumlahsimpananController : jumlahsimpananController,
                        tujuansimpananController : tujuansimpananController,
                        jenissimpananController : jenissimpananController,
                        statussimpananController: statussimpananController,
                      )
                  ),
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