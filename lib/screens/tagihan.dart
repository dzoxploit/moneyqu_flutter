import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal/card-horizontal-simpanan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'package:flutter_moneyqularavel/model/Simpanans.dart';
import 'dart:convert';
import 'dart:developer';

class Tagihan extends StatefulWidget implements PreferredSizeWidget {
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

  const Tagihan(
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
  _TagihanState createState() => _TagihanState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _TagihanState extends State<Tagihan> {
  @override
  Future<List<Simpanans>> simpanans;
  final simpananListKey = GlobalKey<_TagihanState>();

  String name='';
  var tagihan_belum_lunas = 0;
  var tagihan_sudah_lunas = 0;
  var tagihandata;
  var indexdata;

  @override
  void initState(){
    super.initState();
    _loadUserData();
    _getTagihan();
    _getTagihan2();
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

  static String baseUrl = "/tagihan";

  Future<void> _getTagihan2() async {
    final response = await Network().getData(baseUrl);
    indexdata = json.decode(response.body)['data'];
    setState(() {
      tagihan_belum_lunas = indexdata['total_tagihan_belum_lunas'];
      tagihan_sudah_lunas = indexdata['total_tagihan_sudah_lunas'];
      tagihandata = indexdata['data_tagihan'];
    });
  }


  Future<List<Simpanans>> _getTagihan() async {
    final response = await Network().getData(baseUrl);
    final items = json.decode(response.body)['data']['data_tagihan'].cast<Map<String, dynamic>>();
    List<Simpanans> simpanans = items.map<Simpanans>((json) {
      return Simpanans.fromJson(json);
    }).toList();

    return simpanans;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Tagihan"),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            centerTitle: true,
            title: Text('Tagihan'),
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
                                              "Tagihan Lunas",
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
                                          '${tagihan_sudah_lunas}',
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
                                              "Tagihan belum lunas",
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
                                          '${tagihan_belum_lunas}',
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
              child: FutureBuilder<List<Simpanans>>(
                future: _getTagihan(),
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
                          CardHorizontalSimpanan(
                              cta: data.nama_jenis_simpanan,
                              title: data.deskripsi,
                              id_simpanan: data.id,
                              harga: "Rp."+ data.jumlah_simpanan.toString(),
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

        onPressed:(){ Navigator.pushNamed(context, '/tambah-simpanan'); },
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