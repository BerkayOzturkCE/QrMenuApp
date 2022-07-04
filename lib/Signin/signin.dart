import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:staj/Data/data.dart';
import 'package:staj/Widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  double width = 400.0;
  double widthIcon = 200.0;
  String name = "";
  String mail = "";
  String password = "";
  Icon _icon = Icon(Icons.visibility_off);

  late PageController _pageController;

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        width = 190.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Page();
  }

  Widget Page() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 47, 49, 54),
      body: Signup(),
    );
  }

  Widget Signup() {
    bool oku = false;
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60, bottom: 40, right: 30, left: 30),
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
                ),
                Text(
                  "KAYIT OL",
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (String s) {
                    name = s;
                  },
                  readOnly: oku,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                    ),
                    hintText: "İsim",
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
                      Icons.mail_outline_outlined,
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
                    /*suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.visibility_off),padding: EdgeInsets.all(),),*/
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
                    Kaydol();
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
                        "Kayıt Ol",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 800),
                    child: SizedBox(),
                  ));
              setState(() {
                width = 500;
                widthIcon = 0;
              });
            },
            child: AnimatedContainer(
              height: 65.0,
              width: width,
              duration: Duration(milliseconds: 1000),
              curve: Curves.linear,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Hesabınız Var mı ?",
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
                          child: Text(
                            "Giriş Yapın",
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
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color.fromARGB(255, 62, 66, 73),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Kaydol() async {
    try {
      if (name != "" || mail != "" && password != "") {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: mail, password: password);
        User? _newUser = credential.user;
        _newUser?.updateDisplayName(name);

        WarningWidget("Kayıt İşlemi Başarılı.", "Başarılı", context);

        print(_newUser.toString());
      } else {
        WarningWidget("Lütfen boş alanları doldurun.", "Başarısız", context);
      }
    } catch (e) {
      WarningWidget(e.toString(), "Hata", context);
    }
  }
}
