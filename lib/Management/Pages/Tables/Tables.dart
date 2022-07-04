import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staj/classes/worker.dart';

import 'AddTable.dart';

class Tables extends StatefulWidget {
  @override
  _TablesState createState() => _TablesState();
  List workerList = [];
  late double ScHeight;
  late double ScWidth;
  late double x;
}

class _TablesState extends State<Tables> {
  @override
  Widget build(BuildContext context) {
    widget.ScHeight = MediaQuery.of(context).size.height;
    widget.ScWidth = MediaQuery.of(context).size.width;
    listekle();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 25,
          elevation: 0,
          title: Text(
            "Qr kod oluşturma",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addtable()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
        backgroundColor: Color.fromARGB(255, 47, 49, 54),
        body: ListView(
          children: widget.workerList
              .map((worker) => ListItemWidget(worker))
              .toList(),
        ));
  }

  Widget ListItemWidget(Worker worker) {
    return Container(
        height: widget.ScHeight / 7,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180),
                color: Colors.transparent,
              ),
              child: Icon(
                FontAwesomeIcons.chair,
                size: 45,
                color: Colors.white,
              ),
            ),
            Container(
              width: widget.ScWidth / 1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    worker.isim,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Masa ID:  " + worker.Id,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),

            //SizedBox(width: 50,),
            IconButton(
              enableFeedback: true,
              onPressed: () {
                print("deneme");
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

  void listekle() {
    widget.x = widget.ScWidth;
    if (widget.ScWidth > widget.ScHeight) {
      widget.x = widget.ScHeight;
    }

    Worker worker = Worker();
    worker.Id = "Daha sonra tamamlanacak";
    worker.isim = "Masa 22";
    widget.workerList.add(worker);
    Worker worker2 = Worker();
    worker2.Id = "Daha sonra tamamlanacak";
    worker2.isim = "Masa 19";
    widget.workerList.add(worker2);
    Worker worker3 = Worker();
    worker3.Id = "Daha sonra tamamlanacak";
    worker3.isim = "Masa 24";
    widget.workerList.add(worker3);
  }
}
