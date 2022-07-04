import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/classes/OrderContent.dart';
import 'package:staj/classes/orderItems.dart';
import 'package:staj/classes/worker.dart';
import 'package:intl/intl.dart';
import 'AddWorkers.dart';

class Workers extends StatefulWidget {
  @override
  _WorkersState createState() => _WorkersState();
  List<OrderItem> orderList = [];
  late double ScHeight;
  late double ScWidth;
  late double x;
  bool drm = true;
}

class _WorkersState extends State<Workers> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    widget.ScHeight = MediaQuery.of(context).size.height;
    widget.ScWidth = MediaQuery.of(context).size.width;
    Veri_Al();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 25,
          elevation: 0,
          title: Text(
            "Siparişler",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: 60,
          backgroundColor: Color.fromARGB(255, 32, 34, 37),
          actions: [
            IconButton(
                onPressed: () {
                  widget.orderList.clear();
                  widget.drm = true;
                  setState(() {});
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Color.fromARGB(255, 47, 49, 54),
        body: widget.orderList.isEmpty == true && widget.drm == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : ListView(
                children: widget.orderList
                    .map((worker) => ListItemWidget(worker))
                    .toList(),
              ));
  }

  Widget ListItemWidget(OrderItem orderItem) {
    return Container(
        height: ScreenUtil.getHeight(context) / 5,
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
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180),
                color: Colors.transparent,
              ),
              child: Icon(
                FontAwesomeIcons.bell,
                size: ScreenUtil.minimumSize(context) / 7,
                color: Colors.white,
              ),
            ),
            Container(
              width: widget.ScWidth / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.table,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Tarih:  " +
                        DateFormat('dd.MM.yyyy').format(orderItem.tarih),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Ücret:  " + orderItem.Tfiyat.toString(),
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
                  Color.fromARGB(255, 62, 66, 73),
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
            .where("ResId", isEqualTo: "123")
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
