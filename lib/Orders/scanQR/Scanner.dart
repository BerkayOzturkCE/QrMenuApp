
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:staj/Orders/OrderMenu/OrderMenu.dart';

class ScannerQR extends StatefulWidget {
  ScannerQR(this.user);


  @override
  _ScannerQRState createState() => _ScannerQRState();  
   late Barcode result;
   User user;

}

class _ScannerQRState extends State<ScannerQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          titleSpacing: 25,
          elevation: 0,
          centerTitle: true,
               foregroundColor: Colors.white,
        toolbarHeight: 60,
          title: Text(
            "QR Kodunuzu Taratın",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 32, 34, 37),
        ),
        body: Column(children: [ Expanded(flex: 5, child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated)),
       ],),
    );
  }     

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    
    controller.scannedDataStream.listen((scanData) {
      
        result = scanData;
        String Qrdata;
        Qrdata=result.code;
        Qrdata+="&";
        Qrdata+=widget.user.uid;
        print(Qrdata);
        Navigator.popAndPushNamed(context, '/OrderMenu',arguments: Qrdata);
     
    });
  }
void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}