import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool hasSubmitted = false;

  final _formKey = GlobalKey<FormState>(); // do zapisu formularza

  String markaModel = "";
  String opis = "";
  String kolorWlasciwy = "";
  String kwotaZakupu = "";
  String cenaSprzedazy = "";
  String url = "assets/images/carRadio.jpg";
  bool usb = false;
  bool cd = false;
  bool aux = false;
  bool bluetooth = false;
  bool sprzedane = false;
  int rodzaj = 1;
  int kolor = 0;
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dodaj radio"),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.mode_outlined),
                      hintText: "XYZ-563ab",
                      labelText: "Marka - model",
                    ),
                    validator: (value) => !value!.contains("-")
                        ? "Pole musi zawierać pauze '-'"
                        : null,
                    onSaved: (value) {
                      setState(() {
                        markaModel = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.notes_sharp),
                      labelText: "Opis",
                    ),
                    onSaved: (value) {
                      opis = value!;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.image),
                      labelText: "Adres zdjecia",
                    ),
                    onSaved: (value) {
                      url = value!.trim();
                    },
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          activeColor: Colors.blueGrey,
                          splashRadius: 10,
                          value: usb,
                          onChanged: (value) =>
                              setState(() => this.usb = value!)),
                      Text("USB"),
                      Checkbox(
                          activeColor: Colors.blueGrey,
                          splashRadius: 10,
                          value: cd,
                          onChanged: (value) =>
                              setState(() => this.cd = value!)),
                      Text("CD"),
                      Checkbox(
                          activeColor: Colors.blueGrey,
                          splashRadius: 10,
                          value: aux,
                          onChanged: (value) =>
                              setState(() => this.aux = value!)),
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
                    height: 5.0,
                  ),
                  TextFormField(
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixText: "zł",
                      suffixStyle: TextStyle(color: Colors.green),
                      icon: Icon(Icons.price_check),
                      labelText: "Kwota zakupu",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Proszę wpisz kwotę zakupu";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      kwotaZakupu = value!;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixText: "zł",
                      suffixStyle: TextStyle(color: Colors.green),
                      icon: Icon(Icons.sell_outlined),
                      labelText: "Cena sprzedaży",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Proszę wpisz cene sprzedaży";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cenaSprzedazy = value!;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.red.shade400)),
                            onPressed: () {
                              setState(() {
                                _formKey.currentState!.reset();
                                rodzaj=1;
                                usb = false;
                                aux = false;
                                cd = false;
                                bluetooth = false;
                                rating = 0;
                                kolor = 0;
                              });
                            },
                            child: const Text("Wyczyść")),
                            ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.blue.shade400)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                DatabaseReference _radiosRef =
                                    FirebaseDatabase.instance.reference();

                                _radiosRef.child("radiosList").push().set({
                                  "markaModel": markaModel,
                                  "opis": opis,
                                  "kolor": kolor,
                                  "usb": usb,
                                  "cd": cd,
                                  "aux": aux,
                                  "bluetooth": bluetooth,
                                  "rodzaj": rodzaj,
                                  "kwotaZakupu": kwotaZakupu,
                                  "cenaSprzedazy": cenaSprzedazy,
                                  "rating": rating,
                                  "url": url,
                                  "sprzedane": sprzedane,
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Zapisz",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
