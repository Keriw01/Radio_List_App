import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditElement extends StatefulWidget {
  String elementKey;
  EditElement({required this.elementKey});

  @override
  _EditElementState createState() => _EditElementState();
}

class _EditElementState extends State<EditElement> {
  late TextEditingController _markaModelController,
      _opisController,
      _urlController,
      _kwotaZakupuController,
      _cenaSprzedazyController;
  late DatabaseReference _ref;
  int kolor = 0;
  String kwotaZakupu = "";
  String cenaSprzedazy = "";
  bool usb = false;
  bool cd = false;
  bool aux = false;
  bool bluetooth = false;
  int rodzaj = 1;
  double rating = 0;
  @override
  void initState() {
    super.initState();
    _markaModelController = TextEditingController();
    _opisController = TextEditingController();
    _urlController = TextEditingController();
    _kwotaZakupuController = TextEditingController();
    _cenaSprzedazyController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child("radiosList");
    getElementDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edycja elementu"),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _markaModelController,
                decoration: InputDecoration(
                  hintText: "Wprowadź markę i model",
                  prefixIcon: Icon(
                    Icons.mode_outlined,
                    size: 25,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _opisController,
                decoration: InputDecoration(
                  hintText: "Wprowadź opis",
                  prefixIcon: Icon(
                    Icons.notes_sharp,
                    size: 25,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  hintText: "Wprowadź adres zdjęcia",
                  prefixIcon: Icon(
                    Icons.image,
                    size: 25,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<int>(
                      splashRadius: 3,
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                      value: 1,
                      groupValue: kolor,
                      onChanged: (value) {
                        setState(() {
                          kolor = 1;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Radio<int>(
                        splashRadius: 3,
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green),
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green),
                        value: 2,
                        groupValue: kolor,
                        onChanged: (value) {
                          setState(() {
                            kolor = 2;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Radio<int>(
                        splashRadius: 3,
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue),
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue),
                        value: 3,
                        groupValue: kolor,
                        onChanged: (value) {
                          setState(() {
                            kolor = 3;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Radio<int>(
                        splashRadius: 3,
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.deepPurpleAccent),
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.deepPurpleAccent),
                        value: 4,
                        groupValue: kolor,
                        onChanged: (value) {
                          setState(() {
                            kolor = 4;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      activeColor: Colors.blueGrey,
                      splashRadius: 10,
                      value: usb,
                      onChanged: (value) => setState(() => this.usb = value!)),
                  Text("USB"),
                  Checkbox(
                      activeColor: Colors.blueGrey,
                      splashRadius: 10,
                      value: cd,
                      onChanged: (value) => setState(() => this.cd = value!)),
                  Text("CD"),
                  Checkbox(
                      activeColor: Colors.blueGrey,
                      splashRadius: 10,
                      value: aux,
                      onChanged: (value) => setState(() => this.aux = value!)),
                  Text("AUX"),
                  Checkbox(
                      activeColor: Colors.blueGrey,
                      splashRadius: 10,
                      value: bluetooth,
                      onChanged: (value) =>
                          setState(() => this.bluetooth = value!)),
                  Text("BLUETOOTH"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<int>(
                      splashRadius: 8,
                      activeColor: Colors.blueGrey,
                      value: 1,
                      groupValue: rodzaj,
                      onChanged: (value) {
                        setState(() {
                          rodzaj = 1;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text("1 DIN"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Radio<int>(
                        splashRadius: 8,
                        activeColor: Colors.blueGrey,
                        value: 2,
                        groupValue: rodzaj,
                        onChanged: (value) {
                          setState(() {
                            rodzaj = 2;
                          });
                        }),
                  ),
                  Text("2 DIN"),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _kwotaZakupuController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixText: "zł",
                  suffixStyle: TextStyle(color: Colors.green),
                  icon: Icon(Icons.price_check),
                  labelText: "Kwota zakupu",
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _cenaSprzedazyController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixText: "zł",
                  suffixStyle: TextStyle(color: Colors.green),
                  icon: Icon(Icons.sell_outlined),
                  labelText: "Cena sprzedaży",
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text("Ocena produktu"),
                  ),
                  RatingBar.builder(
                      updateOnDrag: true,
                      initialRating: rating,
                      minRating: 1,
                      itemSize: 30,
                      itemCount: 3,
                      itemPadding: EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, _) => Icon(
                          FontAwesomeIcons.solidStar,
                          size: 22,
                          color: Colors.yellow),
                      onRatingUpdate: (rating) => setState(() {
                            this.rating = rating;
                          })),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  child: Text(
                    "Zaktulizuj",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    saveElement();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getElementDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.elementKey).once();

    Map radiosList = snapshot.value;

    _markaModelController.text = radiosList["markaModel"];

    _opisController.text = radiosList["opis"];

    _urlController.text = radiosList["url"];

    _kwotaZakupuController.text = radiosList["kwotaZakupu"];

    _cenaSprzedazyController.text = radiosList["cenaSprzedazy"];

    setState(() {
      usb = radiosList["usb"];
      cd = radiosList["cd"];
      aux = radiosList["aux"];
      bluetooth = radiosList["bluetooth"];
      rodzaj = radiosList["rodzaj"];
      rating = radiosList["rating"].toDouble();
      kolor = radiosList["kolor"];
    });
  }

  void saveElement() {
    String markaModel = _markaModelController.text;
    String opis = _opisController.text;
    String url = _urlController.text;
    String kwotaZakupu = _kwotaZakupuController.text;
    String cenaSprzedazy = _cenaSprzedazyController.text;

    Map<String, dynamic> radiosList = {
      "markaModel": markaModel,
      "opis": opis,
      "url": url,
      "kolor": kolor,
      "usb": usb,
      "cd": cd,
      "aux": aux,
      "bluetooth": bluetooth,
      "rodzaj": rodzaj,
      "cenaSprzedazy": cenaSprzedazy,
      "kwotaZakupu": kwotaZakupu,
      "rating": rating
    };

    _ref.child(widget.elementKey).update(radiosList).then((value) {
      Navigator.pop(context);
    });
  }
}
