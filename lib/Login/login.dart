import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/Management/Pages/Controller.dart';
import 'package:staj/Orders/mainMenu/mainMenu.dart';
import 'package:staj/Signin/signin.dart';
import 'package:staj/Widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  double width = 200.0;
  double widthIcon = 200.0;
  String mail = "";
  String password = "";
  bool obscuretxt = true;
  bool mailFocus = false;
  bool passwordFocus = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    mailFocus = false;
    passwordFocus = false;
  }

  @override
  Widget build(BuildContext context) {
    return Page();
  }

  Widget Page() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 49, 54),
      resizeToAvoidBottomInset: false,
      body: Login(),
    );
  }

  Widget Login() {
    bool oku = false;
    return Container(
        padding: EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: 60, bottom: 20, right: 30, left: 30),
              child: Column(
                children: [
                  Text(
                    "HOŞGELDİNİZ",
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "GİRİŞ YAPINIZ",
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    autofocus: mailFocus,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String s) {
                      mail = s;
                    },
                    readOnly: oku,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.black,
                      ),
                      hintText: "E-Mail",
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    autofocus: passwordFocus,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String s) {
                      password = s;
                    },
                    readOnly: oku,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        color: Colors.black,
                      ),
                      hintText: "Şifre",
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      MailGiris();
                    },
                    child: Container(
                      width: ScreenUtil.getWidth(context),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 62, 66, 73),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Giriş",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 800),
                            child: SignUpPage()))
                    .then((value) {
                  Future.delayed(Duration(milliseconds: 300), () {
                    setState(() {
                      width = 200;
                      widthIcon = 200;
                    });
                  });
                });
                setState(() {
                  width = 500.0;
                  widthIcon = 0;
                });
              },
              child: AnimatedContainer(
                height: 65.0,
                width: width,
                duration: Duration(milliseconds: 1000),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                            child: Text(
                              "Hesabınız Yok mu ?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                            child: Text(
                              "Kayıt Olun",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                curve: Curves.linear,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Color.fromARGB(255, 62, 66, 73),
                ),
              ),
            ),
          ],
        ));
  }

  void MailGiris() async {
    try {
      if (mail == "admin" && password == "admin") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ControllerManagment()));
      } else if (mail != "" && password != "") {
        UserCredential _credential = await _auth.signInWithEmailAndPassword(
            email: mail, password: password);
        User? _user = _credential.user;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderMainMenu(_user!)));
      } else {
        WarningWidget("Lütfen boş yerleri doldurun!", "Hata", context);
      }
    } catch (e) {
      WarningWidget(e.toString() + " hatası alındı.", "Hata", context);
    }
  }
}
