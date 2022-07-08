import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'file:///C:/Users/didin/Documents/flutter_moneyqularavel/lib/widgets/card-horizontal/card-horizontal.dart';
import 'package:flutter_moneyqularavel/widgets/card-small.dart';
import 'package:flutter_moneyqularavel/widgets/card-square.dart';
import 'package:flutter_moneyqularavel/widgets/card-category.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_moneyqularavel/widgets/form/edit/edittagihan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';

class Ubahtagihan extends StatefulWidget implements PreferredSizeWidget {
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

  const Ubahtagihan(
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
  _UbahtagihanState createState() => _UbahtagihanState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _UbahtagihanState extends State<Ubahtagihan> {
  final _dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController namatagihanController;
  TextEditingController deskripsiController;
  TextEditingController jumlahtagihanController;
  TextEditingController kategoritagihanController;
  TextEditingController tanggaltagihanController;
  TextEditingController notagihanController;
  TextEditingController norekeningController;
  TextEditingController kodebankController;
  TextEditingController statustagihanController;
  TextEditingController statuslunasController;

  var indexdata;
  var id_tagihan_data;
  var nama_tagihan;
  var deskripsi;
  var jumlah_tagihan;
  var kategori_tagihan;
  var tanggal_tagihan;
  var no_tagihan;
  var no_rekening;
  var kode_bank;
  var status_tagihan;
  var data;

  String currency='';

  void initState(){
    super.initState();
    _loadUserData();
    _getTagihanById();
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

  Future<void> _getTagihanById() async {
    final response = await Network().getData('/tagihan/update/'+widget.id.toString());
    indexdata = json.decode(response.body)['data'];
    setState(() {
      namatagihanController = new TextEditingController(text:indexdata['nama_tagihan']);
      deskripsiController = new TextEditingController(text:indexdata['deksripsi']);
      jumlahtagihanController = new TextEditingController(text:indexdata['jumlah_tagihan'].toString());
      kategoritagihanController = new TextEditingController(text:indexdata['kategori_tagihan_id'].toString());
      tanggaltagihanController = new TextEditingController(text:indexdata['tanggal_tagihan']);
      notagihanController = new TextEditingController(text:indexdata['no_tagihan'].toString());
      norekeningController = new TextEditingController(text: indexdata['no_rekening']);
      kodebankController = new TextEditingController(text: indexdata['kode_bank']);
      if(indexdata['status_tagihan'] == 1){
        statustagihanController = new TextEditingController(text: 'Active');
      }else if(indexdata['status_tagihan'] == 0){
        statustagihanController = new TextEditingController(text: 'Non Active');
      }
      if(indexdata['status_tagihan_lunas'] == 1){
        statuslunasController = new TextEditingController(text: 'Lunas');
      }else if(indexdata['status_tagihan_lunas'] == 0){
        statuslunasController = new TextEditingController(text: 'Belum Lunas');
      }
    });
  }

  // Http post request to create new data
  void _updateSimpanan() async {
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
          'status_tagihan_lunas': 0,
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

    var res = await Network().postData(data, '/tagihan/update/'+widget.id.toString());
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
      drawer: FlutterMoneyquDrawer(currentPage: "update-tagihan"),
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
                            "Update Tagihan",
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
                      child: AppEdittagihan(
                          formKey: formKey,
                          namatagihanController : namatagihanController,
                          kategoritagihanController : kategoritagihanController,
                          notagihanController : notagihanController,
                          norekeningController : notagihanController,
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