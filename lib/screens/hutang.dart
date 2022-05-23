import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/model/Hutangs.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal/card-horizontal-hutang.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';
import 'dart:developer';

class Hutang extends StatefulWidget implements PreferredSizeWidget {
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

  const Hutang(
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
  _HutangState createState() => _HutangState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _HutangState extends State<Hutang> {
  @override
  Future<List<Hutangs>> hutangs;
  final hutangListKey = GlobalKey<_HutangState>();

  String name='';
  var hutang_dibayar = 0;
  var hutang_belum_dibayar = 0;
  var hutangdata;
  var indexdata;

  @override
  void initState(){
    super.initState();
    _loadUserData();
    _getHutang();
    _getHutang2();
  }


  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  static String baseUrl = "/hutang";

  Future<void> _getHutang2() async {
    final response = await Network().getData(baseUrl);
    indexdata = json.decode(response.body)['data'];
    setState(() {
      hutang_dibayar = indexdata['total_hutang_sudah_dibayar'];
      hutang_belum_dibayar = indexdata['total_hutang_belum_dibayar'];
      hutangdata = indexdata['data_hutang'];
    });
  }


  Future<List<Hutangs>> _getHutang() async {
    final response = await Network().getData(baseUrl);
    final items = json.decode(response.body)['data']['data_hutang'].cast<Map<String, dynamic>>();
    print(items);
    List<Hutangs> hutangs = items.map<Hutangs>((json) {
      return Hutangs.fromJson(json);
    }).toList();

    return hutangs;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Hutang"),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            centerTitle: true,
            title: Text('Hutang'),
            actions: <Widget>[
            ],
          )),
      body: Center(
        child:Column(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/onboard-background.png"),
                      fit: BoxFit.cover)
              ),
              child: Padding(
                padding:
                const EdgeInsets.only(left: 20, right: 10.0, top: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Positioned(
                          top: 170,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Hutang, \n Dibayar',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Color(0XFF00838F),
                                            )
                                          ],
                                        ),
                                        Text(
                                          '${hutang_dibayar}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                    Container(width: 1, height: 50, color: Colors.grey),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Hutang, \n Belum Dibayar',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_downward,
                                              color: Color(0XFF00838F),
                                            )
                                          ],
                                        ),
                                        Text(
                                          '${hutang_belum_dibayar}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Hutangs>>(
                future: _getHutang(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // By default, show a loading spinner.
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  // Render student lists
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data[index];
                      if(data.status_hutang == 1){
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CardHorizontalHutang(
                                nama_hutang: data.nama_hutang,
                                status_hutang: "Lunas",
                                id_hutang: data.id,
                                tanggal_hutang: data.tanggal_hutang,
                                jumlah_hutang: "Rp."+ data.jumlah_hutang.toString(),
                                tap: () {
                                  Navigator.pushNamed(context, '/pro');
                                }
                            ),
                          ],
                        );
                      }else{
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CardHorizontalHutang(
                                nama_hutang: data.nama_hutang,
                                status_hutang: "Belum Lunas",
                                id_hutang: data.id,
                                tanggal_hutang: data.tanggal_hutang,
                                jumlah_hutang: "Rp."+ data.jumlah_hutang.toString(),
                                tap: () {
                                  Navigator.pushNamed(context, '/pro');
                                }
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(

        onPressed:(){ Navigator.pushNamed(context, '/tambah-hutang'); },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
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