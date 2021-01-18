import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mobile/src/models/dbHelper.dart';
import 'package:ocr_mobile/src/pages/eforms.dart';

import '../widgets/menuPop.dart';
import 'history.dart';
import 'ocr.dart';

class NavItem {
  String title;
  IconData icon;
  NavItem(this.title, this.icon);
}

class Master extends StatefulWidget {
  final String title;
  Master({this.title});
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  var _pageController = PageController();
  int pageIndex;
  final appbarkey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    pageIndex = 1;
    _pageController = PageController(initialPage: 1, keepPage: true);
  }

  String _getTitle(int i) {
    switch (i) {
      case 0:
        return "e-forms";
      case 1:
        return "OCR";
      case 2:
        return "History";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffebf2fa),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuPop(),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(_getTitle(pageIndex)),
              ),
            ],
          ),
          key: appbarkey,
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Color(0xff05a081),
          actions: <Widget>[],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: CurvedNavigationBar(
            index: pageIndex,
            animationCurve: Curves.ease,
            animationDuration: Duration(milliseconds: 500),
            items: [
              //change the icon color based on index
              Icon(Icons.web_asset,
                  size: 30,
                  color: pageIndex == 0 ? Color(0xff05a081) : Colors.white),
              Icon(Icons.camera_enhance,
                  size: 30,
                  color: pageIndex == 1 ? Color(0xff05a081) : Colors.white),
              Icon(Icons.history,
                  size: 30,
                  color: pageIndex == 2 ? Color(0xff05a081) : Colors.white)
            ],
            color: Color(0xff05a081),
            backgroundColor: Color(0xffebf2fa),
            buttonBackgroundColor: Color(0xffebf2fa),
            height: 50.0,
            onTap: (int index) {
              setState(() {
                pageIndex = index;
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              });
            },
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            Eforms(),
            OCR(),
            History(),
          ],
          onPageChanged: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
