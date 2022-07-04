import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/Widgets/widgets.dart';
import 'package:staj/classes/OrderContent.dart';
import 'package:staj/classes/orderItems.dart';

class Sepet extends StatefulWidget {
  Sepet(this.orderItem);

  @override
  _SepetState createState() => _SepetState();
  OrderItem orderItem;
}

class _SepetState extends State<Sepet> {
  @override
  Widget build(BuildContext context) {
    toplamHesap();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        elevation: 0,
        title: Text(
          "Sepet-" + widget.orderItem.table,
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
        widget.orderItem.ordersItems.isEmpty == true
            ? Center(
                heightFactor: 5,
                child: Text(
                  "Sepetiniz Boş",
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ))
            : ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: widget.orderItem.ordersItems
                    .map((food) => orderContent(food))
                    .toList(),
              ),
        Container(
          height: ScreenUtil.getHeight(context) / 8,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 54, 57, 63),
          ),
          child: Row(
            children: [
              Text(
                "Toplam Ücret: ",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              Text(
                widget.orderItem.Tfiyat.toString(),
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(
                width: 50,
              ),
              TextButton(
                onPressed: () {
                  int drm = OrderSave();
                  if (drm == 1) {
                    widget.orderItem.ordersItems.clear();
                    setState(() {});
                  }
                },
                child: Text(
                  "Sipariş Ver",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 64, 68, 75),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget orderContent(OrderContent orderContent) {
    return Container(
        height: ScreenUtil.getHeight(context) / 4,
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
                orderContent.ImgUrl,
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
              width: ScreenUtil.getWidth(context) / 1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderContent.FoodName,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Ekstra eklenecekler:  " + orderContent.Extras,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Fiyat:  " + orderContent.price.toString() + "₺",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  widget.orderItem.ordersItems.remove(orderContent);
                  setState(() {});
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 40,
                ))
          ],
        ));
  }

  void toplamHesap() {
    widget.orderItem.Tfiyat = 0;

    for (int i = 0; i < widget.orderItem.ordersItems.length; i++) {
      widget.orderItem.Tfiyat += widget.orderItem.ordersItems[i].price;
    }
  }

  int OrderSave() {
    try {
      DocumentReference ref =
          FirebaseFirestore.instance.collection("Orders").doc();
      String OrderId;
      Map<String, dynamic> eklenecek = Map();
      eklenecek["ResId"] = widget.orderItem.Id;
      eklenecek["UId"] = widget.orderItem.UId;
      eklenecek["ResName"] = widget.orderItem.ResName;
      eklenecek["Resim"] = widget.orderItem.resImage;
      eklenecek["TPrice"] = widget.orderItem.Tfiyat;
      eklenecek["Table"] = widget.orderItem.table;
      eklenecek["Date"] = DateTime.now();

      OrderId = ref.id;
      eklenecek["Id"] = OrderId;

      ref.set(eklenecek);
      for (int i = 0; i < widget.orderItem.ordersItems.length; i++) {
        DocumentReference ref2 = FirebaseFirestore.instance
            .collection("Orders")
            .doc(OrderId)
            .collection("OrderItem")
            .doc();
        Map<String, dynamic> eklenecek2 = Map();
        eklenecek2["Name"] = widget.orderItem.ordersItems[i].FoodName;
        eklenecek2["ImgUrl"] = widget.orderItem.ordersItems[i].ImgUrl;
        eklenecek2["Extras"] = widget.orderItem.ordersItems[i].Extras;
        eklenecek2["Category"] = widget.orderItem.ordersItems[i].category;
        eklenecek2["Price"] = widget.orderItem.ordersItems[i].price;

        ref2.set(eklenecek2);
      }
      WarningWidget("Başarıyla sipariş verildi", "Başarılı", context);
      return 1;
    } catch (error) {
      WarningWidget(error.toString() + "hatası alındı!", "Hata", context);
      return 0;
    }
  }
}
