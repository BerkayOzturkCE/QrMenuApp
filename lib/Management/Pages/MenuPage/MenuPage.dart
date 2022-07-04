import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/Widgets/widgets.dart';
import 'package:staj/classes/extra.dart';
import 'package:staj/classes/food.dart';
import 'AddMenu.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
  List<Food> StarterFood = [];
  List<Food> MainFood = [];
  List<Food> Drinks = [];
  List<Food> Dessert = [];
  late double ScHeight;
  late double ScWidth;
  late double x;
  String ResId = "123";
  bool drm = true;
}

class _MenuPageState extends State<MenuPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Veri_Al();
    widget.ScHeight = MediaQuery.of(context).size.height;
    widget.ScWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 25,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Menü",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: 60,
          backgroundColor: Color.fromARGB(255, 32, 34, 37),
          leading: IconButton(
              onPressed: () {
                widget.drm = true;
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddMenu()))
                      .then((value) => {sState()});
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ))
          ],
        ),
        backgroundColor: Color.fromARGB(255, 47, 49, 54),
        body: ListView(
          children: [
            Column(
              children: [
                ExpansionTile(
                  title: Text(
                    "Başlangıç",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 62, 66, 73),
                  collapsedBackgroundColor: Color.fromARGB(255, 62, 66, 73),
                  leading: Icon(
                    Icons.ramen_dining_sharp,
                    color: Colors.white,
                    size: 40,
                  ),
                  children: [
                    widget.StarterFood.isEmpty == true
                        ? Center(
                            child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Başlangıç Bulunamadı",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                        : ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: widget.StarterFood.map(
                                (food) => ListItemWidget(food)).toList(),
                          ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Ana Yemek",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 62, 66, 73),
                  collapsedBackgroundColor: Color.fromARGB(255, 62, 66, 73),
                  leading: Icon(
                    Icons.dinner_dining,
                    color: Colors.white,
                    size: 40,
                  ),
                  children: [
                    widget.MainFood.isEmpty == true
                        ? Center(
                            child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Anayemek Bulunamadı",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                        : ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: widget.MainFood.map(
                                (food) => ListItemWidget(food)).toList(),
                          ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Tatlı",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 62, 66, 73),
                  collapsedBackgroundColor: Color.fromARGB(255, 62, 66, 73),
                  leading: Icon(
                    Icons.icecream,
                    color: Colors.white,
                    size: 40,
                  ),
                  children: [
                    widget.Dessert.isEmpty == true
                        ? Center(
                            child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Tatlı Bulunamadı",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                        : ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: widget.Dessert.map(
                                (food) => ListItemWidget(food)).toList(),
                          ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "İçecek",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 62, 66, 73),
                  collapsedBackgroundColor: Color.fromARGB(255, 62, 66, 73),
                  leading: Icon(
                    Icons.coffee,
                    color: Colors.white,
                    size: 40,
                  ),
                  children: [
                    widget.Drinks.isEmpty == true
                        ? Center(
                            child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "İçecek Bulunamadı",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                        : ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: widget.Drinks.map(
                                (food) => ListItemWidget(food)).toList(),
                          ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  Widget ListItemWidget(Food food) {
    return Container(
        height: widget.ScHeight / 5,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 54, 57, 63),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: ScreenUtil.getWidth(context) / 5,
              height: ScreenUtil.getHeight(context) / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: Image.network(
                food.photoUrl,
                fit: BoxFit.scaleDown,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              width: widget.ScWidth / 1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.isim,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Kategori:  " + food.Category,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Fiyat:  " + food.fiyat.toString() + "₺",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),

            //SizedBox(width: 50,),
            IconButton(
              enableFeedback: true,
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 47, 49, 54),
                        title: const Text(
                          'Emin misiniz?',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                "Silmek istediğinize emin misiniz?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
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
                                  veriSil(food);
                                  widget.drm = true;
                                  Navigator.pop(context);
                                  if (this.mounted) {
                                    // check whether the state object is in tree
                                    setState(() {
                                      // make changes here
                                    });
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
              },
              icon: Icon(
                Icons.delete,
                size: 35,
                color: Colors.red,
              ),
            ),
          ],
        ));
  }

  void Veri_Al() async {
    debugPrint("qqss");

    if (widget.drm == true) {
      widget.StarterFood.clear();

      widget.MainFood.clear();

      widget.Dessert.clear();

      widget.Drinks.clear();

      var veriler = await _firestore
          .collection("MenuData")
          .where("ResId", isEqualTo: widget.ResId)
          .get();
      debugPrint("aa");

      for (var veri in veriler.docs) {
        Food food = new Food();

        debugPrint(veri.data().toString());

        food.Id = veri.get("Id").toString();
        food.isim = veri.get("YemekAdi").toString();
        food.Category = veri.get("Kategori").toString();
        food.fiyat = double.parse(veri.get("Fiyat"));
        food.photoUrl = veri.get("Resim").toString();
        food.ResId = veri.get("ResId").toString();
        debugPrint(veriler.size.toString());

        if (food.Category == "Başlangıç") {
          widget.StarterFood.add(food);
        } else if (food.Category == "Ana Yemek") {
          widget.MainFood.add(food);
        } else if (food.Category == "Tatlı") {
          widget.Dessert.add(food);
        } else {
          widget.Drinks.add(food);
        }
      }
      debugPrint("ss");

      if (this.mounted) {
        setState(() {
          widget.drm = false;
        });
      }
      ;
    }
  }

  void veriSil(Food food) {
    for (int i = 0; i < food.extrasList.length; i++) {
      _firestore
          .collection("MenuData")
          .doc(food.Id)
          .collection("Extras")
          .doc(food.extrasList[i].Id)
          .delete();
    }
    _firestore.collection("MenuData").doc(food.Id).delete().whenComplete(
        () => {WarningWidget("Başarıyla Silindi", "Başarılı", context)});
  }

  void sState() {
    setState(() {});
  }
}
