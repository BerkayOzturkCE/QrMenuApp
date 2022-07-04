import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/types/barcode.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/Orders/box/box.dart';
import 'package:staj/classes/OrderContent.dart';
import 'package:staj/classes/extra.dart';
import 'package:staj/classes/food.dart';
import 'package:staj/classes/orderItems.dart';

class OrderMenuPage extends StatefulWidget {
  OrderMenuPage(this.QRdata);
  var QRdata;

  @override
  _OrderMenuPageState createState() => _OrderMenuPageState();

  List<Food> StarterFood = [];
  List<Food> MainFood = [];
  List<Food> Drinks = [];
  List<Food> Dessert = [];
  OrderItem orderItem = new OrderItem();

  late double ScHeight;
  late double ScWidth;
  late double x;
  String ResId = "123";
  bool drm = true;
  String photoUrl =
      "https://firebasestorage.googleapis.com/v0/b/insan-bilgisayar.appspot.com/o/pngwing.com%20(1).png?alt=media&token=1d4a3586-dd53-42a4-a039-ebd4ea4da773";
}

class _OrderMenuPageState extends State<OrderMenuPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    widget.QRdata = ModalRoute.of(context)!.settings.arguments;
    resData();
    Veri_Al();
    widget.ScHeight = MediaQuery.of(context).size.height;
    widget.ScWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          titleSpacing: 25,
          elevation: 0,
          title: Text(
            "MENU",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: 60,
          backgroundColor: Color.fromARGB(255, 32, 34, 37),
          actions: [
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sepet(widget.orderItem)));
                  },
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 40,
                  )),
            ),
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
              width: widget.ScWidth / 2.2,
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
            Container(
              height: ScreenUtil.getHeight(context) / 15,
              child: TextButton(
                onPressed: () {
                  SelectExtra(food);
                },
                child: Center(
                  child: Text(
                    "Sepete Ekle",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 62, 66, 73),
                )),
              ),
            )
          ],
        ));
  }

  void Veri_Al() async {
    String data = widget.QRdata;
    var datas = data.split('&');
    debugPrint(datas[0]);
    widget.ResId = datas[0];
    try {
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
          var veriler2 = await _firestore
              .collection("MenuData")
              .doc(food.Id)
              .collection("Extras")
              .get();
          for (var veri2 in veriler2.docs) {
            debugPrint(veri2.data().toString());

            Extra extra = new Extra();
            extra.Id = veri2.get("Id").toString();
            extra.fiyat = veri2.get("Fiyat").toString();
            extra.isim = veri2.get("ExtraIsim").toString();
            extra.isActive = false;
            print(extra);
            food.extrasList.add(extra);
          }

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
    } catch (error) {
      print(error);
    }
  }

  void SelectExtra(Food food) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: Color.fromARGB(255, 47, 49, 54),
          title: const Text(
            'Ektra İçerik Ekle',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Column(
                  children:
                      food.extrasList.map((extra) => ExtraList(extra)).toList(),
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
                    OrderContent orderContent = new OrderContent();
                    orderContent.FoodName = food.isim;
                    orderContent.ImgUrl = food.photoUrl;
                    orderContent.category = food.Category;
                    orderContent.price = food.fiyat;
                    orderContent.Extras = "Ekstra olarak ";

                    if (food.extrasList.isEmpty != true) {
                      for (int i = 0; i < food.extrasList.length; i++) {
                        if (food.extrasList[i].isActive == true) {
                          orderContent.Extras += food.extrasList[i].isim;
                          orderContent.Extras += ",";
                          orderContent.price +=
                              double.parse(food.extrasList[i].fiyat);
                        }
                      }
                    }

                    if (orderContent.Extras == "Ekstra olarak ") {
                      orderContent.Extras += "Bir şey eklenmeyecek";
                    } else {
                      orderContent.Extras += " eklenecek";
                    }
                    widget.orderItem.ordersItems.add(orderContent);
                    Navigator.of(context).pop();
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
      },
    );
  }

  Widget ExtraList(Extra extra) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    extra.isActive = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          width: ScreenUtil.getWidth(context) / 1.2,
          height: ScreenUtil.getHeight(context) / 18,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 62, 66, 73),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: ScreenUtil.getWidth(context) / 2.2,
                child: Text(
                  extra.isim +
                      "(+" +
                      double.parse(extra.fiyat).toString() +
                      "₺)",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Checkbox(
                value: extra.isActive,
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                onChanged: (value) {
                  extra.isActive = value!;
                  setState(() {});
                },
              )
            ],
          ),
        );
      },
    );
  }

  void resData() {
    var data = widget.QRdata.toString().split("&");
    widget.orderItem.Id = data[0];
    widget.orderItem.ResName = "Restoran1";
    widget.orderItem.table = data[1];
    widget.orderItem.UId = data[2];
    widget.orderItem.resImage = widget.photoUrl;
  }
}
