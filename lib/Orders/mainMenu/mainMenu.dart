import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/Management/Pages/MenuPage/AddMenu.dart';
import 'package:staj/Management/Pages/WorkersPage/AddWorkers.dart';
import 'package:staj/Orders/scanQR/Scanner.dart';
import 'package:staj/classes/OrderContent.dart';
import 'package:staj/classes/food.dart';
import 'package:staj/classes/orderItems.dart';

class OrderMainMenu extends StatefulWidget {
  OrderMainMenu(this.user);

  @override
  _OrderMainMenuState createState() => _OrderMainMenuState();
  List<OrderItem> orderList = [];
  User user;
  bool drm = true;
  String Image =
      "https://firebasestorage.googleapis.com/v0/b/stajapp-e6170.appspot.com/o/pngwing.com.png?alt=media&token=6188a828-a02e-4904-a396-677ab958b0da";
}

class _OrderMainMenuState extends State<OrderMainMenu> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Veri_Al();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 25,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Ana Sayfa",
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
                widget.orderList.clear();
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
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Color.fromARGB(255, 47, 49, 54),
        body: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 280,
                child: Text(
                  "Hoş Geldiniz",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 54, 57, 63),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: ClipOval(
                          child: Image.network(
                            widget.Image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
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
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 280,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 280,
                              child: Text(
                                widget.user.displayName.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScannerQR(widget.user)));
                  },
                  child: Text(
                    "Sipariş Ver",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 64, 68, 75),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 54, 57, 63),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.drm == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              "Eski Siparişler",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            )),
                    widget.orderList.isEmpty == true
                        ? Center(
                            child: Text(
                              "Kayıt bulunamadı",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: widget.orderList
                                .map((order) => ListItemWidget(order))
                                .toList(),
                          )
                  ],
                ),
              )
            ]));
  }

  Widget ListItemWidget(OrderItem orderItem) {
    return Container(
        height: ScreenUtil.getHeight(context) / 5,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 62, 66, 73),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: Image.network(
                orderItem.resImage,
              ),
            ),
            Container(
              width: ScreenUtil.getWidth(context) / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.ResName,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Tarih:  " +
                        DateFormat('dd.MM.yyyy').format(orderItem.tarih),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Ücret:  " + orderItem.Tfiyat.toString() + "₺",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            Container(
              height: ScreenUtil.getHeight(context) / 15,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddWorkers(orderItem)));
                },
                child: Center(
                  child: Text(
                    "Ayrıntılar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 47, 49, 54),
                )),
              ),
            )
          ],
        ));
  }

  void Veri_Al() async {
    try {
      if (widget.drm == true) {
        widget.orderList.clear();
        var veriler = await _firestore
            .collection("Orders")
            .where("UId", isEqualTo: widget.user.uid)
            .orderBy("Date", descending: true)
            .get();

        for (var veri in veriler.docs) {
          OrderItem orderItem = new OrderItem();
          debugPrint(veri.data().toString());

          orderItem.Id = veri.get("Id").toString();
          orderItem.ResName = veri.get("ResName").toString();
          orderItem.Tfiyat = double.parse(veri.get("TPrice").toString());
          orderItem.table = veri.get("Table");
          orderItem.resImage = veri.get("Resim").toString();
          Timestamp date = veri.get("Date");
          orderItem.tarih = date.toDate();

          var veriler2 = await _firestore
              .collection("Orders")
              .doc(orderItem.Id)
              .collection("OrderItem")
              .get();
          for (var veri2 in veriler2.docs) {
            debugPrint(veri2.data().toString());

            OrderContent orderContent = new OrderContent();
            orderContent.FoodName = veri2.get("Name").toString();
            orderContent.Extras = veri2.get("Extras").toString();
            orderContent.ImgUrl = veri2.get("ImgUrl").toString();
            orderContent.category = veri2.get("Category").toString();

            orderContent.price = double.parse(veri2.get("Price").toString());
            orderItem.ordersItems.add(orderContent);
          }
          widget.orderList.add(orderItem);
        }

        setState(() {
          widget.drm = false;
        });
      }
    } catch (error) {
      print(error);
    }
  }
}
