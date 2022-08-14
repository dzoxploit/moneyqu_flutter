import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:flutter_moneyqularavel/widgets/form/formtagihan.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'file:///C:/Users/didin/Documents/flutter_moneyqularavel/lib/widgets/card-horizontal/card-horizontal.dart';
import 'package:flutter_moneyqularavel/widgets/card-small.dart';
import 'package:flutter_moneyqularavel/widgets/card-square.dart';
import 'package:flutter_moneyqularavel/widgets/card-category.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_moneyqularavel/widgets/form/formsimpanan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'package:flutter_moneyqularavel/model/Tagihans.dart';

class Tambahtagihan extends StatefulWidget implements PreferredSizeWidget {
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

  const Tambahtagihan(
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
  _TambahtagihanState createState() => _TambahtagihanState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _TambahtagihanState extends State<Tambahtagihan> {
  String currency='';
  final formKey = GlobalKey<FormState>();
  var data;
  TextEditingController namatagihanController = new TextEditingController();
  TextEditingController deskripsiController = new TextEditingController();
  TextEditingController jumlahtagihanController = new TextEditingController();
  TextEditingController kategoritagihanController = new TextEditingController();
  TextEditingController tanggaltagihanController = new TextEditingController();
  TextEditingController notagihanController = new TextEditingController();
  TextEditingController norekeningController = new TextEditingController();
  TextEditingController kodebankController = new TextEditingController();
  TextEditingController statustagihanController = new TextEditingController();
  TextEditingController statuslunasController = new TextEditingController();

  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var settingsdata = jsonDecode(localStorage.getString('settings'));

    if(settingsdata != null) {
      setState(() {
        currency = settingsdata['currency_id'];
      });
    }
  }
  // Http post request to create new data
  void _createTagihan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var settingsdata = jsonDecode(localStorage.getString('settings'));

    if(statustagihanController.text == "Active"){
      if(statuslunasController.text == "Lunas"){
      data = {
        'nama_tagihan' : namatagihanController.text,
        'kategori_tagihan_id' : kategoritagihanController.text,
        'no_tagihan' : notagihanController.text,
        'no_rekening' : notagihanController.text,
        'jumlah_tagihan' : jumlahtagihanController.text,
        'status_tagihan': 1,
        'status_tagihan_lunas': 1,
        'kode_bank' : kodebankController.text,
        'deskripsi' : deskripsiController.text,
        'tanggal_tagihan' : tanggaltagihanController.text
      };
      }else{
        data = {
          'nama_tagihan' : namatagihanController.text,
          'kategori_tagihan_id' : kategoritagihanController.text,
          'no_tagihan' : notagihanController.text,
          'no_rekening' : notagihanController.text,
          'jumlah_tagihan' : jumlahtagihanController.text,
          'status_tagihan': 1,
          'status_tagihan_lunas': 0,
          'kode_bank' : kodebankController.text,
          'deskripsi' : deskripsiController.text,
          'tanggal_tagihan' : tanggaltagihanController.text
        };
      }
    }else{
      if(statuslunasController.text == "Lunas") {
        data = {
          'nama_tagihan': namatagihanController.text,
          'kategori_tagihan_id': kategoritagihanController.text,
          'no_tagihan': notagihanController.text,
          'no_rekening': notagihanController.text,
          'jumlah_tagihan': jumlahtagihanController.text,
          'status_tagihan': 0,
          'status_tagihan_lunas': 1,
          'kode_bank': kodebankController.text,
          'deskripsi': deskripsiController.text,
          'tanggal_tagihan': tanggaltagihanController.text
        };
      }else{
        data = {
          'nama_tagihan': namatagihanController.text,
          'kategori_tagihan_id': kategoritagihanController.text,
          'no_tagihan': notagihanController.text,
          'no_rekening': notagihanController.text,
          'jumlah_tagihan': jumlahtagihanController.text,
          'status_tagihan': 0,
          'status_tagihan_lunas': 0,
          'kode_bank': kodebankController.text,
          'deskripsi': deskripsiController.text,
          'tanggal_tagihan': tanggaltagihanController.text
        };
      }
    }

    var res = await Network().postData(data, '/tagihan/create');
    print(res.body);
    var body = json.decode(res.body);
    if(body['status'] == 201){
      Navigator.pushReplacementNamed(context, '/tagihan');
    }else{
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Tambah-pemasukan"),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text("Create"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            if (formKey.currentState.validate()) {
              _createTagihan();
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
                            "Create Simpanan",
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
                      child: AppFormtagihan(
                        formKey: formKey,
                          namatagihanController : namatagihanController,
                          kategoritagihanController : kategoritagihanController,
                          notagihanController : notagihanController,
                          norekeningController : norekeningController,
                          jumlahtagihanController : jumlahtagihanController,
                          statustagihanController: statustagihanController,
                          statuslunasController: statuslunasController,
                          kodebankController : kodebankController,
                          deskrispiController : deskripsiController,
                          tanggaltagihanController : tanggaltagihanController
                      ),
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