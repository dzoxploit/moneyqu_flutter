import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/model/Tujuankeuangans.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal/card-horizontal-tujuan-keuangan.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal/card-horizontal-goals-tujuan-keuangan.dart';
import 'package:flutter_moneyqularavel/screens/crud/tujuankeuangan/tambahgoals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_moneyqularavel/network/api.dart';
import 'package:flutter_moneyqularavel/model/GoalsTujuanKeuangans.dart';
import 'dart:convert';
import 'dart:developer';

class DetailGoalsTujuanKeuangan extends StatefulWidget implements PreferredSizeWidget {
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

  const DetailGoalsTujuanKeuangan(
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
  _DetailGoalsTujuanKeuanganState createState() => _DetailGoalsTujuanKeuanganState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _DetailGoalsTujuanKeuanganState extends State<DetailGoalsTujuanKeuangan> {
  @override
  Future<List<GoalsTujuankeuangans>> goals;
  final detailgoalsListKey = GlobalKey<_DetailGoalsTujuanKeuanganState>();
  var name;
  var id_tujuan_keuangan;
  @override
  void initState(){
    super.initState();
    id_tujuan_keuangan = widget.id;
    _loadUserData();
    _getGoalsTujuanKeuangan();
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
  Future<List<GoalsTujuankeuangans>> _getGoalsTujuanKeuangan() async {
    print(widget.id.toString());
    final response = await Network().getData("/detail-tujuan-keuangan/"+widget.id.toString());
    final items = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
    print(items);
    List<GoalsTujuankeuangans> goals = items.map<GoalsTujuankeuangans>((json) {
      return GoalsTujuankeuangans.fromJson(json);
    }).toList();

    return goals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Detail Goals Tujuan Keuangan"),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            centerTitle: true,
            title: Text('Detail Goals Tujuan Keuangan'),
            actions: <Widget>[
            ],
          )),
      body: Center(
        child:Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<GoalsTujuankeuangans>>(
                future: _getGoalsTujuanKeuangan(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // By default, show a loading spinner.
                  if (!snapshot.hasData) return Center(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                      ),
                    ),
                  )
                  ;
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
                            CardHorizontalGoalsTujuanKeuangan(
                                nama: data.nama_goals_tujuan_keuangan,
                                nominal: data.nominal,
                                id_goals_tujuan_keuangan: data.id,
                                tanggal: data.created_at
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

        onPressed:(){ Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Tambahgoals(id: id_tujuan_keuangan)),
        );},
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