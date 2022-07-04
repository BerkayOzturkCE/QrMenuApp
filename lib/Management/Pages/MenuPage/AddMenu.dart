import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/Widgets/widgets.dart';
import 'package:staj/classes/extra.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
  List<Extra> extraList = [];
  String resId = "123";
}

class _AddMenuState extends State<AddMenu> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _controller = new TextEditingController();
  List<String> _kategori = ["Başlangıç", "Ana Yemek", "Tatlı", "İçecek"];
  String kategori = "Başlangıç";
  int sayac = 0;
  String yemekAdi = "", fiyat = "", resimUrl = "";
  bool oku = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        elevation: 0,
        title: Text(
          "Yemek Ekle",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 32, 34, 37),
      ),
      backgroundColor: Color.fromARGB(255, 47, 49, 54),
      body: ListView(children: [
        Container(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 30),
                      width: ScreenUtil.getWidth(context) * 0.60,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (String s) {
                          setState(() {
                            yemekAdi = s;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Yemek Adı",
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(20),
                          prefixIcon: Padding(
                            child: Icon(
                              Icons.dining_outlined,
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.only(
                              left: 14,
                              right: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, right: 20),
                      width: ScreenUtil.getWidth(context) * 0.25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (String s) {
                          setState(() {
                            fiyat = s;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Fiyat",
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: ScreenUtil.getWidth(context) * 0.50,
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: TextField(
                        controller: _controller,
                        readOnly: oku,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (String s) {
                          resimUrl = s;
                        },
                        decoration: InputDecoration(
                          hintText: "Resim Url adresi",
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(20),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              left: 14,
                              right: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  oku = true;
                                  _controller.text = "Yükleniyor...";
                                  photo_url_al();
                                });
                              },
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenUtil.getWidth(context) * 0.35,
                      margin: EdgeInsets.only(top: 30, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(left: 10.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        dropdownColor: Colors.grey[200],
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 10,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        elevation: 0,
                        iconSize: 25,
                        items: _kategori.map((secili) {
                          return DropdownMenuItem(
                            child: Text(
                              secili,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: secili,
                          );
                        }).toList(),
                        onChanged: (deger) {
                          setState(() {
                            kategori = deger!;
                          });
                        },
                        value: kategori,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: Text(
                    "Ekstralar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 62, 66, 73),
                  collapsedBackgroundColor: Color.fromARGB(255, 62, 66, 73),
                  leading: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: widget.extraList
                          .map((extraItem) => Extras(extraItem))
                          .toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                      heroTag: "flab1",
                      extendedIconLabelSpacing: 10,
                      backgroundColor: Color.fromARGB(255, 185, 187, 190),
                      icon: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 62, 66, 73),
                        size: 20,
                      ),
                      label: Text(
                        "Ekle",
                        style: TextStyle(
                          color: Color.fromARGB(255, 62, 66, 73),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        AddExtra();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "flab2",
        label: Text("Kaydet"),
        backgroundColor: Color.fromARGB(255, 185, 187, 190),
        extendedIconLabelSpacing: 10,
        icon: Icon(
          Icons.add,
          color: Color.fromARGB(255, 62, 66, 73),
          size: 20,
        ),
        onPressed: () {
          ekle();
          setState(() {});
        },
      ),
    );
  }

  Widget Extras(Extra extra) {
    return Container(
        height: ScreenUtil.getHeight(context) / 12,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 54, 57, 63),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: ScreenUtil.getHeight(context) / 5,
                    child: Text(
                      extra.isim,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Fiyat:  " + double.parse(extra.fiyat).toString() + "₺",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),

            //SizedBox(width: 50,),
            IconButton(
              onPressed: () {
                setState(() {
                  print("deneme");
                  widget.extraList.remove(extra);
                });
              },
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Colors.red,
              ),
            ),
          ],
        ));
  }

  void AddExtra() {
    Extra extra = new Extra();
    extra.fiyat = "";
    extra.isim = "";
    String errtext = "Boş bırakmayın!", errname = "", errprice = "";
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 47, 49, 54),
            title: const Text(
              'Ektra İçerik Ekle',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String s) {
                      setState(() {
                        extra.isim = s;
                      });
                    },
                    decoration: InputDecoration(
                      errorText: errname,
                      hintText: "İçerik Adı",
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String s) {
                      setState(() {
                        extra.fiyat = s;
                      });
                    },
                    decoration: InputDecoration(
                      errorText: errprice,
                      hintText: "İçerik Fiyatı",
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kaydetmek istiyor musunuz?',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 62, 66, 73),
                    )),
                    child: const Text(
                      'Kaydet',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (extra.isim == "") {
                        errname = errtext;
                        setState(() {});
                      } else {
                        errname = "";
                      }
                      if (extra.fiyat == "") {
                        errprice = errtext;
                        setState(() {});
                      } else {
                        errname = "";
                      }
                      if (extra.isim != "" && extra.fiyat != "") {
                        widget.extraList.add(extra);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 62, 66, 73),
                    )),
                    child: const Text(
                      'Hayır',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        });
      },
    );
  }

  void photo_url_al() async {
    try {
      var resim = await ImagePicker()
          .pickImage(source: ImageSource.gallery)
          .onError((error, stackTrace) => null);
      if (resim != null) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child("images")
            .child(resim.path);
        firebase_storage.UploadTask uploadTask = ref.putFile(File(resim.path));
        debugPrint(resim.path);

        resimUrl = await (await uploadTask.whenComplete(() => null))
            .ref
            .getDownloadURL();
        debugPrint(resimUrl);

        setState(() {
          _controller.text = resimUrl;

          oku = false;
        });
      } else {
        setState(() {
          _controller.text = "";

          oku = false;
        });
      }
    } catch (error) {
      WarningWidget(error.toString(), "Hata", context);
    }
  }

  Future<void> ekle() async {
    // ignore: await_only_futures
    try {
      if (yemekAdi == "" || fiyat == "" || kategori == "" || resimUrl == "") {
        WarningWidget("Lütfen boş yerleri doldurun!", "Hata", context);
        return;
      }

      DocumentReference ref =
          FirebaseFirestore.instance.collection("MenuData").doc();
      String foodId;
      Map<String, dynamic> eklenecek = Map();
      eklenecek["YemekAdi"] = yemekAdi;
      eklenecek["Fiyat"] = fiyat;
      eklenecek["Kategori"] = kategori;
      eklenecek["Resim"] = resimUrl;
      eklenecek["ResId"] = widget.resId;
      foodId = ref.id;
      eklenecek["Id"] = foodId;

      ref.set(eklenecek);
      for (int i = 0; i < widget.extraList.length; i++) {
        DocumentReference ref2 = FirebaseFirestore.instance
            .collection("MenuData")
            .doc(foodId)
            .collection("Extras")
            .doc();
        Map<String, dynamic> eklenecek2 = Map();
        eklenecek2["ExtraIsim"] = widget.extraList[i].isim;
        eklenecek2["Fiyat"] = widget.extraList[i].fiyat;
        eklenecek2["Id"] = ref2.id;
        ref2.set(eklenecek2);
      }
      WarningWidget("Başarıyla kaydedildi", "Başarılı", context);
    } catch (error) {
      WarningWidget(error.toString(), "Hata", context);
    }
  }
}
