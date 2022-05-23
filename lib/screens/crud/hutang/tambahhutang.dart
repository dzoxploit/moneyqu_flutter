import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_moneyqularavel/widgets/form/formhutang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:developer';
class Tambahhutang extends StatefulWidget implements PreferredSizeWidget {
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

  const Tambahhutang(
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
  _TambahhutangState createState() => _TambahhutangState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _TambahhutangState extends State<Tambahhutang> {
  String currency='';
  final _dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController namahutangController = new TextEditingController();
  TextEditingController deksripsiController = new TextEditingController();
  TextEditingController jumlahhutangController = new TextEditingController();
  TextEditingController noteleponController = new TextEditingController();
  TextEditingController tanggalhutangController = new TextEditingController();

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
  void _createHutang() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var settingsdata = jsonDecode(localStorage.getString('settings'));

    var data = {
      'nama_hutang': namahutangController.text,
      'deksripsi' : deksripsiController.text,
      'currency_id': settingsdata['currency_id'],
      'jumlah_hutang': jumlahhutangController.text,
      'no_telepon': noteleponController.text,
      'tanggal_hutang': tanggalhutangController.text,
    };

    var res = await Network().postData(data, '/hutang/create');
    print(res.body);
    var body = json.decode(res.body);
    if(body['status'] == 201){
      Navigator.pushReplacementNamed(context, '/hutang');
    }else{
      Navigator.of(context).pushReplacementNamed('/hutang');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Tambah-hutang"),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text("Create"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            if (formKey.currentState.validate()) {
              _createHutang();
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
                            "Create Hutang",
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
                      child: AppFormhutang(
                          formKey: formKey,
                          namahutangController: namahutangController,
                          deksripsiController : deksripsiController,
                          jumlahhutangController : jumlahhutangController,
                          tanggalhutangController : tanggalhutangController,
                          noteleponController : noteleponController
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