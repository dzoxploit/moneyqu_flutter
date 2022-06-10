import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal/card-horizontal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'package:flutter_moneyqularavel/model/Pemasukans.dart';
import 'dart:convert';
import 'dart:developer';

class Pemasukan extends StatefulWidget implements PreferredSizeWidget {
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

  const Pemasukan(
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
  _PemasukanState createState() => _PemasukanState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _PemasukanState extends State<Pemasukan> {
  @override
  Future<List<Pemasukans>> pemasukans;
  final pemasukanListKey = GlobalKey<_PemasukanState>();

  String name='';
  var pemasukan_total;
  var pemasukan_hari_ini;
  var pemasukandata;
  var indexdata;

  @override
  void initState(){
    super.initState();
    _loadUserData();
    _getPemasukan2();
    _getPemasukan();
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

  static String baseUrl = "/pemasukan";

  Future<void> _getPemasukan2() async {
    final response = await Network().getData(baseUrl);
    indexdata = json.decode(response.body)['data'];
    setState(() {
      pemasukan_total = indexdata['pemasukan'];
      pemasukan_hari_ini = indexdata['pemasukan_hari_ini'];
      pemasukandata = indexdata['data_pemasukan'];
    });
  }


    Future<List<Pemasukans>> _getPemasukan() async {
      final response = await Network().getData(baseUrl);
      final items = json.decode(response.body)['data']['data_pemasukan'].cast<Map<String, dynamic>>();
      List<Pemasukans> pemasukans = items.map<Pemasukans>((json) {
        return Pemasukans.fromJson(json);
      }).toList();

      return pemasukans;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Pemasukan"),
      key: pemasukanListKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            centerTitle: true,
            title: Text('Pemasukan'),
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
                                              "Pemasukan",
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
                                          '${pemasukan_total}',
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
                                              "Pemasukan Hari Ini",
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
                                          '${pemasukan_hari_ini}',
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
              child: FutureBuilder<List<Pemasukans>>(
                future: _getPemasukan(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // By default, show a loading spinner.
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  // Render student lists
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CardHorizontal(
                          cta: "View data",
                          title: data.nama,
                          id_pemasukan: data.id,
                          category: data.kategori,
                          harga: "Rp."+ data.jumlah_pemasukan.toString(),
                          tap: () {
                            Navigator.pushNamed(context, '/pro');
                          }
                      ),
                        ],
                      );
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

        onPressed:(){ Navigator.pushNamed(context, '/tambah-pemasukan'); },
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