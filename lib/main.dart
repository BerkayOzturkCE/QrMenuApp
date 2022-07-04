import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:staj/Login/login.dart';
import 'package:staj/Orders/OrderMenu/OrderMenu.dart';
import 'package:staj/Orders/mainMenu/mainMenu.dart';
import 'package:flutter/services.dart';
import 'Management/Pages/Controller.dart';
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MaterialApp(
      

      debugShowCheckedModeBanner: false,
      title: 'RestorApp',
      theme: ThemeData(
        

        primarySwatch: Colors.cyan,
      ),
      home: App(),
      routes: <String, WidgetBuilder> {
    '/OrderMenu': (BuildContext context) => new OrderMenuPage("deneme"),
  },
    );
  }
}


class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Hata();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginPage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Wait();
      },
    );
  }
}

class Hata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Bağlantı hatası",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Wait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

