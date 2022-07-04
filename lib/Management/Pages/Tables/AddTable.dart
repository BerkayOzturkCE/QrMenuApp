import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:staj/Data/data.dart';

class Addtable extends StatefulWidget {
  @override
  _AddtableState createState() => _AddtableState();
  late String resID = "123";
  late String qrData = "";
  late String MasaIsim = "";
  late double ScHeight;
  late double ScWidth;
  late double x;
}

class _AddtableState extends State<Addtable> {
  @override
  Widget build(BuildContext context) {
    widget.ScHeight = MediaQuery.of(context).size.height;
    widget.ScWidth = MediaQuery.of(context).size.width;
    boyutAl();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 25,
        elevation: 0,
        title: Text(
          "Qr Kod Oluşturma",
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
      body: Center(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: QrImage(
                data: widget.resID + "&" + widget.MasaIsim,
                version: QrVersions.auto,
                size: ScreenUtil.minimumSize(context) / 2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (String s) {
                setState(() {
                  widget.MasaIsim = s;
                });
              },
              decoration: InputDecoration(
                hintText: "Masa Adı",
                hintStyle: TextStyle(
                  fontSize: 18,
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
          ],
        ),
      )),
    );
  }

  void boyutAl() {
    widget.x = widget.ScWidth;
    if (widget.ScWidth > widget.ScHeight) {
      widget.x = widget.ScHeight;
    }
  }
}
