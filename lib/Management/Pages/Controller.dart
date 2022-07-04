import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staj/Management/Pages/MenuPage/MenuPage.dart';
import 'package:staj/Management/Pages/Tables/AddTable.dart';
import 'package:staj/Management/Pages/Tables/Tables.dart';
import 'package:staj/Management/Pages/WorkersPage/Workers.dart';
import 'package:staj/Management/Pages/mainScreen/mainScreen.dart';

class ControllerManagment extends StatefulWidget {
  const ControllerManagment({Key? key}) : super(key: key);

  @override
  _ControllerManagmentState createState() => _ControllerManagmentState();
}

class _ControllerManagmentState extends State<ControllerManagment> {
  int _currentIndexPage = 0;
  final _bottomNavigatorBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Anamenü"),
    BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined), label: "Menü"),
    BottomNavigationBarItem(
        icon: Icon(Icons.notifications_active_outlined), label: "Siparişler"),
    BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: "Qr kod")
  ];

  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (pageIndex) {
          setState(() {
            _currentIndexPage = pageIndex;
            print(pageIndex);
          });
        },
        //scrollDirection: Axis.horizontal,
        children: [MainScreen(), MenuPage(), Workers(), Addtable()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 32, 34, 37),
        items: _bottomNavigatorBarItems,
        currentIndex: _currentIndexPage,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
