import 'package:flutter/material.dart';
import 'package:flutter_moneyqularavel/widgets/drawer.dart';
import 'package:flutter_moneyqularavel/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_moneyqularavel/widgets/card-horizontal.dart';
import 'package:flutter_moneyqularavel/widgets/card-small.dart';
import 'package:flutter_moneyqularavel/widgets/card-square.dart';
import 'package:flutter_moneyqularavel/widgets/card-category.dart';
import 'package:flutter_moneyqularavel/widgets/slider-product.dart';
final Map<String, Map<String, dynamic>> articlesCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image":
    "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image":
    "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Coffee is more than just a drink: It’s …",
    "image":
    "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
  },
  "Fashion": {
    "title": "Fashion is a popular style, especially in …",
    "image":
    "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
  },
  "Argon": {
    "title": "Argon is a great free UI packag …",
    "image":
    "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  },
  "Music": {
    "title": "View article",
    "image":
    "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
    "products": [
      {
        "img":
        "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
        "title": "Painting Studio",
        "description":
        "You need a creative space ready for your art? We got that covered.",
        "price": "\$125",
      },
      {
        "img":
        "https://images.unsplash.com/photo-1500628550463-c8881a54d4d4?fit=crop&w=2698&q=80",
        "title": "Art Gallery",
        "description":
        "Don't forget to visit one of the coolest art galleries in town.",
        "price": "\$200",
      },
      {
        "img":
        "https://images.unsplash.com/photo-1496680392913-a0417ec1a0ad?fit=crop&w=2700&q=80",
        "title": "Video Services",
        "description":
        "Some of the best music video services someone could have for the lowest prices.",
        "price": "\$300",
      },
    ],
    "suggestions": [
      {
        "img":
        "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music studio for real..."
      },
      {
        "img":
        "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music equipment to borrow..."
      },
    ]
  }
};

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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterMoneyquDrawer(currentPage: "Piutang"),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
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
                            "Piutang",
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
                          ),
                        ],
                      ),
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
                                                "Sudah Dibayar",
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
                                            "\Rp. 0",
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
                                                "Belum Dibayar",
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
                                            "\Rp. 100.000",
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
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.grey.shade100,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: CardHorizontal(
                                cta: "View article",
                                title: articlesCards["Ice Cream"]['title'],
                                img: articlesCards["Ice Cream"]['image'],
                                tap: () {
                                  Navigator.pushNamed(context, '/pro');
                                }),
                          ),
                          SizedBox(height: 8.0),
                          CardHorizontal(
                              cta: "View article",
                              title: articlesCards["Fashion"]['title'],
                              img: articlesCards["Fashion"]['image'],
                              tap: () {
                                Navigator.pushNamed(context, '/pro');
                              }),
                          SizedBox(height: 8.0),
                          CardHorizontal(
                              cta: "View article",
                              title: articlesCards["Fashion"]['title'],
                              img: articlesCards["Fashion"]['image'],
                              tap: () {
                                Navigator.pushNamed(context, '/pro');
                              }),
                          SizedBox(height: 8.0),
                          CardHorizontal(
                              cta: "View article",
                              title: articlesCards["Fashion"]['title'],
                              img: articlesCards["Fashion"]['image'],
                              tap: () {
                                Navigator.pushNamed(context, '/pro');
                              }),
                          SizedBox(height: 8.0),
                          CardHorizontal(
                              cta: "View article",
                              title: articlesCards["Fashion"]['title'],
                              img: articlesCards["Fashion"]['image'],
                              tap: () {
                                Navigator.pushNamed(context, '/pro');
                              }),
                          SizedBox(height: 8.0),
                          CardHorizontal(
                              cta: "View article",
                              title: articlesCards["Fashion"]['title'],
                              img: articlesCards["Fashion"]['image'],
                              tap: () {
                                Navigator.pushNamed(context, '/pro');
                              }),

                        ],
                      ),
                    )
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(

        onPressed:(){ Navigator.pushReplacementNamed(context, '/tambah-piutang'); },
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