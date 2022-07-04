import 'package:flutter/material.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/classes/OrderContent.dart';
import 'package:staj/classes/orderItems.dart';

class AddWorkers extends StatefulWidget {
  AddWorkers(this.orderItem);

  @override
  _AddWorkersState createState() => _AddWorkersState();
  OrderItem orderItem;
}

class _AddWorkersState extends State<AddWorkers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        elevation: 0,
        title: Text(
          "Sipariş Ayrıntısı",
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
        ListView(
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
                widget.orderItem.Tfiyat.toString() + "₺",
                style: TextStyle(fontSize: 22, color: Colors.white),
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
          ],
        ));
  }
}
