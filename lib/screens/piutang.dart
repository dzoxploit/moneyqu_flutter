import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/model/Piutangs.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal/card-horizontal-piutang.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'dart:convert';
import 'dart:developer';

class Piutang extends StatefulWidget implements PreferredSizeWidget {
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

  const Piutang(
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
  _PiutangState createState() => _PiutangState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _PiutangState extends State<Piutang> {
  @override
  Future<List<Piutangs>> piutangs;
  final piutangListKey = GlobalKey<_PiutangState>();

  String name='';
  var piutang_dibayar = 0;
  var piutang_belum_dibayar = 0;
  var piutangdata;
  var indexdata;

  @override
  void initState(){
    super.initState();
    _loadUserData();
    _getPiutang();
    _getPiutang2();
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

  static String baseUrl = "/piutang";

  Future<void> _getPiutang2() async {
    final response = await Network().getData(baseUrl);
    indexdata = json.decode(response.body)['data'];
    setState(() {
      piutang_dibayar = indexdata['total_piutang_sudah_dibayar'];
      piutang_belum_dibayar = indexdata['total_piutang_belum_dibayar'];
      piutangdata = indexdata['data_piutang'];
    });
  }


  Future<List<Piutangs>> _getPiutang() async {
    final response = await Network().getData(baseUrl);
    final items = json.decode(response.body)['data']['data_piutang'].cast<Map<String, dynamic>>();
    print(items);
    List<Piutangs> piutangs = items.map<Piutangs>((json) {
      return Piutangs.fromJson(json);
    }).toList();

    return piutangs;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Piutang"),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            centerTitle: true,
            title: Text('Piutang'),
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
                                              'Piutang, \n Dibayar',
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
                                          '${piutang_dibayar}',
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
                                              'Piutang, \n Belum Dibayar',
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
                                          '${piutang_belum_dibayar}',
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
              child: FutureBuilder<List<Piutangs>>(
                future: _getPiutang(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // By default, show a loading spinner.
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  // Render student lists
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data[index];
                      if(data.status_piutang == 1){
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CardHorizontalPiutang(
                                nama_piutang: data.nama_piutang,
                                status_piutang: "Lunas",
                                id_piutang: data.id,
                                tanggal_piutang: data.tanggal_piutang,
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
                            CardHorizontalPiutang(
                                nama_piutang: data.nama_piutang,
                                status_piutang: "Lunas",
                                id_piutang: data.id,
                                tanggal_piutang: data.tanggal_piutang,
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

        onPressed:(){ Navigator.pushNamed(context, '/tambah-piutang'); },
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