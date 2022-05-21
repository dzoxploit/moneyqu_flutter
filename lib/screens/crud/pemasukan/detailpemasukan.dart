import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/screens/crud/pemasukan/ubahpemasukan.dart';
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

class Detailpemasukan extends StatefulWidget implements PreferredSizeWidget {
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

  const Detailpemasukan(
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
  _DetailpemasukanState createState() => _DetailpemasukanState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _DetailpemasukanState extends State<Detailpemasukan> {
  final _dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var indexdata;
  var id_pemasukan;
  var nama_pemasukan;
  var kategori_pemasukan;
  var jumlah_pemasukan;
  var tanggal_pemasukan;
  var keterangan;

  String currency='';

  void initState(){
    super.initState();
    _loadUserData();
    _getPemasukanById();
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

  Future<void> _getPemasukanById() async {
    final response = await Network().getData('/pemasukan?id='+widget.id.toString());
    indexdata = json.decode(response.body)['data']['data_pemasukan'];
    setState(() {
      id_pemasukan = indexdata['id'];
      nama_pemasukan = indexdata['nama'];
      kategori_pemasukan = indexdata['kategori'].toString();
      jumlah_pemasukan =  indexdata['jumlah_pemasukan'].toString();
      tanggal_pemasukan = indexdata['tanggal_pemasukan'].toString();
      keterangan =  indexdata['keterangan'];
    });
  }
  void _deletePemasukan() async {
    var data = null;
    var res = await Network().postData(data, '/pemasukan/destroy/'+id_pemasukan.toString());
    print(res.body);
    var body = json.decode(res.body);
    if(body['status'] == 201){
      Navigator.pushReplacementNamed(context, '/pemasukan');
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
                            "Detail Pemasukan",
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
                                _deletePemasukan();
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
                                          text: "Nama"),
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
                                      text: nama_pemasukan),
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
                                          text: "Kategori"),
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
                                          text: kategori_pemasukan),
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
                                          text: "Jumlah"),
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
                                          text: "Rp. " +jumlah_pemasukan.toString()),
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
                                          text: "Tanggal"),
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
                                          text: tanggal_pemasukan),
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
                                          text: "Keterangan"),
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
                                          text: keterangan),
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
          MaterialPageRoute(builder: (context) => Ubahpemasukan(id: id_pemasukan)),
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