import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:radio_list/my_icons_icons.dart';
import 'selled_list_element.dart';
import 'edit_element.dart';
import 'add_element.dart';
import 'dart:ui' as ui;

class ListPage extends StatefulWidget {
  @override
  _ListPage createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  late Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child("radiosList");
  Color kolorKwotaZakupu = Colors.black;
  IconData iconDolar = Icons.attach_money_sharp;
  final IconData star = FontAwesomeIcons.star;
  final IconData starSolid = FontAwesomeIcons.solidStar;
  final double size = 22;
  final Color yellow = Colors.yellow;
  

  @override
  void initState() {
    super.initState();
    _ref =
        FirebaseDatabase.instance.reference().child("radiosList").orderByChild("sprzedane").equalTo(false);
  }

  Widget _buildElementItem({Map? radiosList}) {
    getRate() {
      return Column(children: [
        if (radiosList!["rating"] == 0)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(star, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(star, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(star, size: size, color: yellow),
            ],
          )
        else if (radiosList["rating"] == 1)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(starSolid, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(star, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(star, size: size, color: yellow),
            ],
          )
        else if (radiosList["rating"] == 2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(starSolid, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(starSolid, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(star, size: size, color: yellow),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(starSolid, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(starSolid, size: size, color: yellow),
              SizedBox(
                width: 3,
              ),
              Icon(starSolid, size: size, color: yellow),
            ],
          )
      ]);
    }

    getUsb() {
      return radiosList!["usb"] ? Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 2.0),
        child: Icon(MyIcons.flash_drive),
      ) : null;
    }

    getCd() {
      return radiosList!["cd"]
          ? Padding(
            padding: const EdgeInsets.only(right: 2.0, left: 2.0),
            child: Icon(MyIcons.cd_player,),
          )
          : null;
    }

    getAux() {
      return radiosList!["aux"] ? Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: Icon(MyIcons.jack_cable,),
      ) : null;
    }

    getBluetooth() {
      return radiosList!["bluetooth"]
          ? Padding(
            padding: EdgeInsets.only(right: 4.0, left: 2.0),
            child: Icon(FontAwesomeIcons.bluetooth, size: 22, color: Colors.blue.shade900,),): null;
    }

    getColor() {
      int kolor = radiosList!["kolor"];
      if (kolor == 1) {
        return Icon(Icons.circle, color: Colors.red);
      } else if (kolor == 2) {
        return Icon(Icons.circle, color: Colors.blue);
      } else if (kolor == 3) {
        return Icon(Icons.circle, color: Colors.green);
      } else if (kolor == 4) {
        return Tab(
            icon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return ui.Gradient.radial(
                    Offset(20.0, 40.0),
                    50.0,
                    [
                      Colors.red,
                      Colors.blue,
                    ],
                    [
                      0.5,
                      1.0,
                    ],
                  );
                },
                child: Icon(Icons.circle)));
      } else
        return Icon(
          Icons.circle_outlined,
          color: Colors.grey.shade200,
        );
    }

    getImage() {
      String url = radiosList!["url"];
      if (url.startsWith("https://")) {
        return Image.network(
          url,
          width: 100,
          height: 100,
        );
      } else
        return Image.asset(
          "assets/images/carRadio.png",
          width: 100,
          height: 100,
        );
    }

    ImageProvider getBigImage() {
      String url = radiosList!["url"];
      if (url.startsWith("https://")) {
        return NetworkImage(url);
      } else
        return AssetImage("assets/images/carRadio.png");
    }

    void _showSecondPage(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => GestureDetector(
                child: Scaffold(
                  body: Center(
                    child: Hero(
                        tag: radiosList!["markaModel"],
                        child: PhotoView(
                          imageProvider: getBigImage(),
                          backgroundDecoration: BoxDecoration(color: Colors.white),
                        )
                        ),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              )));
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  radiosList!["markaModel"],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  EditElement(elementKey: radiosList["key"])));
                    },
                    icon: Icon(MyIcons.edit, size: 20, color: Colors.grey.shade600,)),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    _showDeleteDialog(radioList: radiosList);
                  },
                  icon: Icon(MyIcons.down_arrow_on_shopping_basket, color: Colors.red.shade300),
                  splashRadius: 1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                child: Hero(tag: radiosList["markaModel"], child: getImage()),
                onTap: () => _showSecondPage(context),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        radiosList["opis"],
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text("${radiosList["rodzaj"].toString()} DIN"),
                  ],
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Zakup: ${radiosList["kwotaZakupu"]} zł",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: kolorKwotaZakupu),
                    ),
                  ),
                  Text(
                    "Cena: ${radiosList["cenaSprzedazy"]} zł",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text("Stan"),
              ),
              Expanded(
                flex: 1,
                child: getRate()),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(child: getUsb()),
                    Container(child: getCd()),
                    Container(child: getAux()),
                    Container(child: getBluetooth()),
                    Container(
                      child: getColor(),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  _showDeleteDialog({Map? radioList}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sprzedać ${radioList!['markaModel']} ?"),
            content: Text("Czy ten element został sprzedany ?"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Nie")),
                    TextButton(
                        onPressed: () {
                          bool sprzedane = true;
                          Map<String, dynamic> radiosList = {
                            "sprzedane": sprzedane,
                          };
                          reference
                              .child(radioList["key"])
                              .update(radiosList)
                              .whenComplete(() => Navigator.pop(context));
                        },
                        child: Text("Tak"))
                  ],
                ),
              ),
            ],
          );
        });
  }

  hideKwotaZakupu() {
    if (kolorKwotaZakupu == Colors.black) {
      setState(() {
        kolorKwotaZakupu = Colors.white;
        iconDolar = Icons.money_off;
      });
    } else if (kolorKwotaZakupu == Colors.white) {
      setState(() {
        kolorKwotaZakupu = Colors.black;
        iconDolar = Icons.attach_money_sharp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: Text("Lista"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              child: Icon(
                iconDolar,
                size: 25,
                color: Colors.green.shade300,
              ),
              onLongPress: () {
                hideKwotaZakupu();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              child: Icon(
                MyIcons.shopping_list,
                size: 25,
                color: Colors.blueGrey.shade800,
              ),
              onLongPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SelledListPage()));
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: _ref,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map radiosList = snapshot.value;
              radiosList["key"] = snapshot.key;
              return _buildElementItem(radiosList: radiosList);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return AddPage();
            }),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
